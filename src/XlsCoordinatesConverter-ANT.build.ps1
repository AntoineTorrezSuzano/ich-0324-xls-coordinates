Import-Module Pester

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

task update-manifest {
	$Params = @{
		Path = "./XlsCoordinatesConverter-ANT.psd1"
		Author = "CP-22ANT"
		CompanyName = "Ceff Industrie Eleve"
		Copyright = "(c) 2025 CP-22ANT Fictive Corporation. All rights reserved."
		ModuleVersion = '0.0.5'
	}
	Update-ModuleManifest @Params
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

task Feature {
	Invoke-Build analyse-script
	Invoke-Build Tests-N-Coverage
}

task Build-Module {
	Invoke-Build analyse-script
	Invoke-Build Tests-N-Coverage
	Invoke-Build update-manifest
	Set-Location ..
	Remove-Item ./out -Recurse -Force
	New-Item -ItemType Directory ./out/XlsCoordinatesConverter-ANT
	Copy-Item ./src/* ./out/XlsCoordinatesConverter-ANT -Recurse
	Move-Item ./out/XlsCoordinatesConverter-ANT/XlsCoordinatesConverter-ANT.ps1 ./out/XlsCoordinatesConverter-ANT/XlsCoordinatesConverter-ANT.psm1 -Force
	Add-Content -Path "./out/XlsCoordinatesConverter-ANT/XlsCoordinatesConverter-ANT.psm1" -Value "`nExport-ModuleMember -Function ConvertFrom-XlsCoordinate"
}

task Release {
	Invoke-Build Build-Module
	Invoke-Build Publish
}
