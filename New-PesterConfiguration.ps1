$config = New-PesterConfiguration

$config.Run.Path = "./../XlsCoordinatesConverter-ANT"

$config.CodeCoverage.Enabled = $true

Invoke-Pester -Configuration $config