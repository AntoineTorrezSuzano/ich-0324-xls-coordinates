### Own Script

```cmd
. .\XlsCoordinatesConverter.psm1
```

```cmd
Import-Module .\XlsCoordinatesConverter.psm1
```

```cmd
Parse-Table aaa
```

### PSScriptAnalyzer Module

```pwsh
    Get-ScriptAnalyzerRule
```

```pwsh
    Invoke-Formatter
```

### Pester Module

```pwsh
    Invoke-Pester
```

### Invoke Build Module

```pwsh
    Invoke-Build
```

### Default Modules Install

```pwsh
Install-Module -Name PSScriptAnalyzer -RequiredVersion 1.24.0 -Force
```

### Create a psd1 file (Manifest file)

```pwsh
New-ModuleManifest -Path .\XlsCoordinatesConverter.psd1 -RootModule 'XlsCoordinatesConverter.psm1' -Author "Opaline" -Description "This is an exemple of manifest description section" -FunctionsToExport 'ConvertFrom-XlsCoordinates'
```

### Publish a module file

```pwsh
Publish-Module -Path .\XlsCoordinatesConverter -NuGetApiKey 'theapikeyfromyouaccountapikeysectioninpowershellgallery'
```

Tips :
The module need to be in a folder, the folder must contain the .psm1 file and the .psd1 file which is a manifest file that can be created with the command New-ModuleManifest above
also I got some problem at home from my ssl tunnel or idk is
not secure enough, gotta see how is it at school

### Update a module

```pwsh
    Update-PSResource -Name XlsCoordinatesConverter
```

### Get a look at Powershell version

```pwsh
    $PSVersionTable.PSVersion
```
