BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe "Parse-Table" {
    Context "Return input value" {
        It "Return aaa" {
            $result = ConvertFrom-XlsCoordinates -Cell aaa | Should -Be 'aaa'
            
        }
    }

    # Context "Convert a1" {
    #     It "Returns [1,1]" {
    #         $result = ConvertFrom-XlsCoordinates -Cell a1 
    #         $result.Column | Should -Be 1
    #         $result.Row | Should -Be 1
    #     }
    # }
    # Context "Convert A1" {
    #     It "Returns [1,1]" {
    #         $result = ConvertFrom-XlsCoordinates -Cell a1 
    #         $result.Column | Should -Be 1
    #         $result.Row | Should -Be 1
    #     }
    # }
    # Context "Convert AA234" {
    #     It "Returns [27,234]" {
    #         $result = ConvertFrom-XlsCoordinates -Cell a1s
    #         $result.Column | Should -Be 27
    #         $result.Row | Should -Be 234
    #     }
    # }
    # Context "Convert tata" {
    #     It "Throw an ArgumentException : Parameter tata is an invalid format" {
    #         {ConvertFrom-XlsCoordinates -Cell tata} | Should -Throw -ExceptionType ([System.ArgumentException]) 
    #     }
    # }
    # Context "Convert TATATOTO123" {
    #     It "Throw an InvalidOperationException : Parameter tata is an invalid format" {
    #         {ConvertFrom-XlsCoordinates -Cell TATATOTO123} | Should -Throw -ExceptionType ([System.InvalidOperationException]) 
    #     }
    # }
    # Context "Convert 3D" {
    #     It "Returns [4,3]" {
    #         ConvertFrom-XlsCoordinates -Cell D3 | Should -Be '[4,3]'
    #     }
    # }
    # Context "Convert AB23" {
    #     It "Returns [28,23]" {
    #         ConvertFrom-XlsCoordinates -Cell AB23 | Should -Be '[28,23]'
    #     }
    # }
    # Context "Convert 23" {
    #     It "Error: Invalid Format" {
    #         ConvertFrom-XlsCoordinates -Cell 23 | Should -Be "Error: Invalid Format"
    #     }
    # }
    # Context "Convert AB" {
    #     It "Error: Bad Input, lack in number" {
    #         ConvertFrom-XlsCoordinates -Cell AB | Should -Be "Error: Bad Input, lack in number"
    #     }
    # }

    # Context "Convert Z2A" {
    #     It "Returns [1,1]" {
    #         ConvertFrom-XlsCoordinates -Cell Z2A | Should -Be "Error: bad structur, ex: AB51"
    #     }
    # }
    # Context "Convert 2Z1" {
    #     It "Error: bad structur, ex: AB51" {
    #         ConvertFrom-XlsCoordinates -Cell 2Z1 | Should -Be "Error: bad structur, ex: AB51"
    #     }
    # }

    # Context "Convert TATATOTO123" {
    #     It "Error: bad structur, ex: AB51" {
    #         ConvertFrom-XlsCoordinates -Cell TATATOTO123 | Should -Be "Error: bad input, lack in number"
    #     }
    # }
    # Context "Convert èàa" {
    #     It "Error: Bad Input, lack in number" {
    #         ConvertFrom-XlsCoordinates -Cell èàa | Should -Be "Error: Bad Input, lack in number"
    #     }
    # }   
    # Context "Convert èàa23" {
    #     It "Error: Bad Input" {
    #         ConvertFrom-XlsCoordinates -Cell èàa23 | Should -Be "Error: Bad Input"
    #     }
    # }

}