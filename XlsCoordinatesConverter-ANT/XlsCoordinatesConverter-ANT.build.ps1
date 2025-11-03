Import-Module Pester

#psscript analyser
task formatfiles {

}

task analyse-script {
	$filesToAnalyze = @(
		'./XlsCoordinatesConverter-ANT.ps1',
		'./XlsCoordinatesConverter-ANT.psm1',
		'./XlsCoordinatesConverter-ANT.psd1',
		'./XlsCoordinatesConverter-ANT.Tests.ps1',
		'./XlsCoordinatesConverter-ANT.build.ps1'
	)
	$issues = @()
	foreach ($file in $filesToAnalyze) {
		$issues += Invoke-ScriptAnalyzer -Path $file -Severity 'Warning', 'Error'
	}

	if($issues.Count -gt 0) {
		$issues | Format-Table -AutoSize
		$failedFiles = $issues.ScriptName | Select-Object -Unique

		throw "Analyse script requires modification in file(s): $($failedFiles -join ',')"
	}
	else {
		Write-Output "No sever issues were found in the scripts"
	}
}

task Tests {
	#tester code coverage 100%
	$pesterResult = Invoke-Pester -PassThru

	if($pesterResult.FailedCount -gt 0) {
		throw "Pester tests failed."
	}
}

# mise a jour manifest
task update-manifest {
	$Params = @{
		Path = "./XlsCoordinatesConverter-ANT.psd1"
		Author = "CP-22ANT"
		CompanyName = "Ceff Industrie Eleve"
		Copyright = "(c) 2025 CP-22ANT Fictive Corporation. All rights reserved."
		ModuleVersion = '0.0.2'
	}
	Update-ModuleManifest @Params

}

task Release {
	Invoke-Build analyse-script
	Invoke-Build Tests
	Invoke-Build update-manifest

	$env = @{}
	get-content "../.env" | ForEach-Object {
		$name, $value = $_.split('=')
		$env.Add($name, $value)
	}
	Publish-Module -Path '..\XlsCoordinatesConverter-ANT' -NuGetApiKey $env["NuGetApiKey"]
}