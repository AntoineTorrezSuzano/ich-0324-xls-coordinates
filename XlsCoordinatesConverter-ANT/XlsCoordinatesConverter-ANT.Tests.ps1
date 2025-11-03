BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe "ConvertFrom-XlsCoordinate Module" {

   Context "Convert a1" {
       It "Returns [1,1]" {
           $result = ConvertFrom-XlsCoordinate -Cell a1 
           $result.Column | Should -Be 1
           $result.Row | Should -Be 1
       }
   }
    Context "Convert A1" {
        It "Returns [1,1]" {
            $result = ConvertFrom-XlsCoordinate -Cell A1 
            $result.Column | Should -Be 1
            $result.Row | Should -Be 1
        }
    }
    Context "Convert AA234" {
        It "Returns [27,234]" {
            $result = ConvertFrom-XlsCoordinate -Cell AA234
            $result.Column | Should -Be 27
            $result.Row | Should -Be 234
        }
    }
    # Context "Convert tata" {
    #    It "Throw an ArgumentException : Parameter tata is an invalid format" {
    #        {ConvertFrom-XlsCoordinate -Cell tata} | Should -Throw -ExceptionType ([System.ArgumentException]) 
    #    }
    # }
    #Context "Convert TATATOTO123" {
    #    It "Throw an InvalidOperationException : Parameter tata is an invalid format" {
    #        {ConvertFrom-XlsCoordinate -Cell TATATOTO123} | Should -Throw -ExceptionType ([System.InvalidOperationException]) 
    #    }
    #}
    Context "Convert 3D" {
        It "Returns [4,3]" {
            { ConvertFrom-XlsCoordinate -Cell '3D'} | Should -Throw
        }
    }

    #Context "Convert èàa" {
    #    It "Error: Bad Input, lack in number" {
    #        ConvertFrom-XlsCoordinate -Cell èàa | Should -Be "Error: Bad Input, lack in number"
    #    }
    #}   
    #Context "Convert èàa23" {
    #    It "Error: Bad Input" {
    #        ConvertFrom-XlsCoordinate -Cell èàa23 | Should -Be "Error: Bad Input"
    #    }
    #}

}