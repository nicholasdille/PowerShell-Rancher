function Get-RancherVolume {
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
        [switch]
        $Raw
    )

    $Volumes = Invoke-RancherApi -Path '/volumes'
    $Volumes = $Volumes | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $Volumes
        return
    }
    
    foreach ($Volume in $Volumes) {
        [pscustomobject]@{
            Environment = $Volume.accountId
            Instance    = $Volume.instanceId
            Id          = $Volume.id
            Name        = $Volume.name
            State       = $Volume.state
            Mode        = $Volume.accessMode
            Driver      = $Volume.driver
            Host        = $Volume.hostId
            Mounts      = $Volume.mounts.Length
            Uuid        = $Volume.uuid
            PSTypeName  = 'RancherVolume'
        }
    }
}