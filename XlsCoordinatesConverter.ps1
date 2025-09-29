function Parse-Table ([string]$Cell) {
    $result="["
    $letterSide = 0
    $numberSide = ""
    $numOfLetter=0
    $passedLetter=$false
    $CellUpper=$Cell.ToUpper();
    $letters = @();

    foreach ($char in [char[]]$CellUpper) {
        # Separate between letters and numbers (Row & Col)
        if($char -match "^\d+$"){
            # If it turns true that means there's numbers and that normally there are no more letter to parse
            $passedLetter=$True
        } else {
            if($passedLetter -eq $true){
                # That is because there was letters after numbers, which is an invalide format
                Throw New-Object System.ArgumentException "Parameter $Cell is an invalid format"
            }
            # We count the number of Letters
            $numOfLetter++

            Write-Host "Add $char in letters array";
            $letters += $char;

        }
    }

    Write-Host "Letters array : $letters";


    
    # if($numOfLetter -eq -1){
    #     Throw New-Object System.ArgumentException "Parameter $Cell is an invalid format"
    #     # return "Error: Invalid Format"
    # }

    # $result+=","
    # $numOfNumber=-1
    # foreach ($char in [char[]]$CellUpper) {
    #     if($char -match "^\d+$"){
    #         $numberSide+=$char
    #         $numOfNumber++
    #     } else {
            
    #     }
    # }
    # if($numOfNumber -eq -1){
    #     # return "Error: Bad Input, lack in number"
    #     Throw New-Object System.ArgumentException "Parameter $Cell is an invalid format"
    # }
    # $column = $letterSide 
    # $rows = $numberSide
    # return [PSCustomObject]@{
    #     Column = $column 
    #     Row = $rows
    # };
}
