function ConvertFrom-XlsCoordinate ([string]$Cell) {
    <#
    .DESCRIPTION
        This cmdlet accept a String value for the parameter "-Cell" and it will return a the format value of the given cell as value usable in excel. You would want to view the example.

    .EXAMPLE
        PS C:\> ConvertFrom-XlsCoordinate -Cell "B4"
    #>

    $CellUpper=$Cell.ToUpper(); # Format the parameters to upper characters
    $passedLetter=$false

    $columnLetters = "" #String
    $rowNumbers = "" #String

    foreach ($char in [char[]]$CellUpper) {
        # Separate between letters and numbers (Row & Col)
        if($char -match "^\d+$"){
            # If it turns true that means there's numbers and that normally there are no more letter to parse
            $passedLetter=$True

            $rowNumbers += $char;
        } else {
            if($passedLetter -eq $true){
                # That is because there was letters after numbers, which is an invalide format
                Throw New-Object System.ArgumentException "Parameter $Cell is an invalid format"
            }

            $columnLetters += $char;

        }
    }

    if ($columnLetters.Length -eq 0) {
        Throw New-Object System.ArgumentException "Parameter $Cell is an invalid format. No column letters found."
    }
    if ($rowNumbers.Length -eq 0) {
        Throw New-Object System.ArgumentException "Parameter $Cell is an invalid format. No row number found."
    }
    $row = [int]$rowNumbers

    $columnIndex = 0

    foreach($letter in [char[]]$columnLetters){
        $columnIndex = $columnIndex * 26
        $letterValue = [int]$letter - [int]([char]'A') + 1
        $columnIndex += $letterValue
    }

    return [PSCustomObject]@{
        Column = $columnIndex
        Row = $row
    }

    #Export-ModuleMember -Function ConvertFrom-XlsCoordinate


}
