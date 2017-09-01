function Get-RancherMount {
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
        if ($Volume.mounts -is [array]) {
            foreach ($Mount in $Volume.mounts) {
                [pscustomobject]@{
                    Environment  = $Volume.accountId
                    Host         = $Volume.hostId
                    Name         = $Mount.volumeName
                    Instance     = $Mount.instanceId
                    InstanceName = $Mount.instanceName
                    Volume       = $Mount.volumeId
                    Mode         = $Mount.permission
                    PSTypeName   = 'RancherMount'
                }
            }
        }
    }
}