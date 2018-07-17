function Set-RancherServer {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Server
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $AccessKey
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $SecretKey = (Read-Host -Prompt 'Password' -AsSecureString | Get-PlaintextFromSecureString)
    )

    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }

    process {
        if ($Force -or $PSCmdlet.ShouldProcess("Update credentials to use server '$Server' with access key '$AccessKey'?")) {
            $script:RancherServer    = $Server
            $script:RancherAccessKey = $AccessKey
            $script:RancherSecretKey = $SecretKey
        }
    }
}
