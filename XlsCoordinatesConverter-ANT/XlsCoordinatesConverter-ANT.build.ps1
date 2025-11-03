Import-Module Pester

#psscript analyser
task formatfiles {

}

task Tests {
	$pesterResult = Invoke-Pester -PassThru

	if($pesterResult.FailedCount -gt 0) {
		throw "Pester tests failed."
	}
}

# mise a jour manifest
task update-manifest {
	$Params = @{
		Path = "./cp-22antXlsCoordinatesConverter.psd1"
		Author = "CP-22ANT"
		CompanyName = "Ceff Industrie Eleve"
		Copyright = "(c) 2025 CP-22ANT Fictive Corporation. All rights reserved."
		ModuleVersion = '0.0.1'
	}
	Update-ModuleManifest @Params

}

task Release {
	$env = @{}
	get-content "../.env" | ForEach-Object {
		$name, $value = $_.split('=')
		$env.Add($name, $value)
	}
	Write-Host $env["NuGetApiKey"]
	# Publish-Module -Path .\XlsCoordinatesConverter -NuGetApiKey $env["NuGetApiKey"]
}