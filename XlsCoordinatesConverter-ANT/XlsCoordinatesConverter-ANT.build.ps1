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



task Tests-N-Coverage {
	#tester code coverage 100%
	$config = New-PesterConfiguration

	$config.Run.Path = "."

	$config.Run.PassThru = $true

	$config.CodeCoverage.Enabled = $true


	$pesterResult = Invoke-Pester -Configuration $config

	if($pesterResult.FailedCount -gt 0) {
		throw "Pester tests failed."
	}

	$coverageData = $pesterResult.CodeCoverage

    $coveragePercent = [math]::Round($coverageData.CoveragePercent, 2)

    Write-Output "Current Code Coverage: $coveragePercent%"

    if ($coveragePercent -lt 10) {
        throw "Code coverage is below 10%. Actual coverage: $coveragePercent%"
    }
}



# mise a jour manifest
task update-manifest {
	$Params = @{
		Path = "./XlsCoordinatesConverter-ANT.psd1"
		Author = "CP-22ANT"
		CompanyName = "Ceff Industrie Eleve"
		Copyright = "(c) 2025 CP-22ANT Fictive Corporation. All rights reserved."
		ModuleVersion = '0.0.3'
	}
	Update-ModuleManifest @Params

}
task Pre-Publish-Tests {
	Invoke-Build analyse-script
	Invoke-Build Tests-N-Coverage
}

task Publish {
	$TargetApiKey = $env:NUGETAPIKEY
	if ([string]::IsNullOrWhiteSpace($TargetApiKey)) {
		$env = @{}
		get-content "../.env" | ForEach-Object {
			$name, $value = $_.split('=')
			$env.Add($name, $value)
		}
		Write-Output ".env file was used"
		#Publish-Module -Path '..\XlsCoordinatesConverter-ANT' -NuGetApiKey $env["NuGetApiKey"]
	} else {
		Write-Output "environment variable set by the workflow was used"
		#Publish-Module -Path '..\XlsCoordinatesConverter-ANT' -NuGetApiKey $TargetApiKey
	}

}


task Release {
	Invoke-Build analyse-script
	Invoke-Build Tests-N-Coverage
	Invoke-Build update-manifest
	Invoke-Build Publish
}