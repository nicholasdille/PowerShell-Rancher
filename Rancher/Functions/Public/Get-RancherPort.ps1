function Get-RancherPort {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id = '*'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $EnvironmentId = '*'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $InstanceId = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Ports = Invoke-RancherApi -Path '/ports'
    $Ports = $Ports | Where-Object { $_.id -like $Id -and $_.instanceId -like $InstanceId -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $Ports
        return
    }
    
    $Ports | ForEach-Object {
        [pscustomobject]@{
            Environment     = $_.accountId
            Instance        = $_.instanceId
            Id              = $_.id
            Port            = $_.privatePort
            IPAddress       = $_.privateIpAddressId
            PublicIPAddress = $_.publicIpAddressId
            PublicPort      = $_.publicPort
            Uuid            = $_.uuid
            PSTypeName      = 'RancherPort'
        }
    }
}