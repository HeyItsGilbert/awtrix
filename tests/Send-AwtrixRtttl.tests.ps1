BeforeAll {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\awtrix\awtrix.psm1'
    Get-Module awtrix | Remove-Module -Force -ErrorAction Ignore
    Import-Module $modulePath -Force

    & (Get-Module awtrix) { $script:AwtrixConnection = @{ BaseUri = 'http://192.168.1.100' } }
}

Describe 'Send-AwtrixRtttl' {

    BeforeAll {
        Mock Invoke-RestMethod {} -ModuleName awtrix
    }

    It 'Sends RTTTL string as raw body' {
        $rtttl = 'Super Mario:d=4,o=5,b=100:16e6,16e6,32p,8e6,16c6,8e6,8g6'
        Send-AwtrixRtttl -RtttlString $rtttl
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Uri -eq 'http://192.168.1.100/api/rtttl' -and
            $Method -eq 'POST' -and
            $Body -eq $rtttl -and
            $ContentType -eq 'text/plain'
        }
    }

    It 'Accepts positional parameter' {
        Send-AwtrixRtttl 'TakeOnMe:d=4,o=4,b=160:8f#5'
        Should -Invoke Invoke-RestMethod -ModuleName awtrix -ParameterFilter {
            $Body -eq 'TakeOnMe:d=4,o=4,b=160:8f#5'
        }
    }
}
