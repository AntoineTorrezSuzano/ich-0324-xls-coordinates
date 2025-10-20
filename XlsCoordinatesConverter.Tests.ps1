BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe "Parse-Table" {
    Context "Convert a1" {
        It "Returns [1,1]" {
            $result = Parse-Table -Cell a1 
            $result.Column | Should -Be 1
            $result.Row | Should -Be 1
        }
    }
    Context "Convert A1" {
        It "Returns [1,1]" {
            $result = Parse-Table -Cell a1 
            $result.Column | Should -Be 1
            $result.Row | Should -Be 1
        }
    }
    Context "Convert AA234" {
        It "Returns [27,234]" {
            $result = Parse-Table -Cell a1s
            $result.Column | Should -Be 27
            $result.Row | Should -Be 234
        }
    }
    # Context "Convert tata" {
    #     It "Throw an ArgumentException : Parameter tata is an invalid format" {
    #         {Parse-Table -Cell tata} | Should -Throw -ExceptionType ([System.ArgumentException]) 
    #     }
    # }
    # Context "Convert TATATOTO123" {
    #     It "Throw an InvalidOperationException : Parameter tata is an invalid format" {
    #         {Parse-Table -Cell TATATOTO123} | Should -Throw -ExceptionType ([System.InvalidOperationException]) 
    #     }
    # }
    # Context "Convert 3D" {
    #     It "Returns [4,3]" {
    #         Parse-Table -Cell D3 | Should -Be '[4,3]'
    #     }
    # }
    # Context "Convert AB23" {
    #     It "Returns [28,23]" {
    #         Parse-Table -Cell AB23 | Should -Be '[28,23]'
    #     }
    # }
    # Context "Convert 23" {
    #     It "Error: Invalid Format" {
    #         Parse-Table -Cell 23 | Should -Be "Error: Invalid Format"
    #     }
    # }
    # Context "Convert AB" {
    #     It "Error: Bad Input, lack in number" {
    #         Parse-Table -Cell AB | Should -Be "Error: Bad Input, lack in number"
    #     }
    # }

    # Context "Convert Z2A" {
    #     It "Returns [1,1]" {
    #         Parse-Table -Cell Z2A | Should -Be "Error: bad structur, ex: AB51"
    #     }
    # }
    # Context "Convert 2Z1" {
    #     It "Error: bad structur, ex: AB51" {
    #         Parse-Table -Cell 2Z1 | Should -Be "Error: bad structur, ex: AB51"
    #     }
    # }

    # Context "Convert TATATOTO123" {
    #     It "Error: bad structur, ex: AB51" {
    #         Parse-Table -Cell TATATOTO123 | Should -Be "Error: bad input, lack in number"
    #     }
    # }
    # Context "Convert èàa" {
    #     It "Error: Bad Input, lack in number" {
    #         Parse-Table -Cell èàa | Should -Be "Error: Bad Input, lack in number"
    #     }
    # }   
    # Context "Convert èàa23" {
    #     It "Error: Bad Input" {
    #         Parse-Table -Cell èàa23 | Should -Be "Error: Bad Input"
    #     }
    # }

}