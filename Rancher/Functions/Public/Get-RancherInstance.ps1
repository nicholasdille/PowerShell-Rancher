function Get-RancherInstance {
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
        $HostId = '*'
        ,
        [Parameter()]
        [ValidateSet('running', 'stopping', 'stopped', 'purged', 'creating')]
        [string]
        $State = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Instances = Invoke-RancherApi -Path '/instances'
    $Instances = $Instances | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId -and $_.hostId -like $HostId }

    if ($Raw) {
        $Instances
        return
    }
    
    $Instances | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Host        = $_.hostId
            Id          = $_.id
            Name        = $_.name
            State       = $_.state
            Services    = $_.serviceIds
            Uuid        = $_.uuid
            PSTypeName  = 'RancherInstance'
        }
    }
}