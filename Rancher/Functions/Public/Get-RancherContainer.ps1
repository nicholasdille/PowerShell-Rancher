function Get-RancherContainer {
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
        $StackId = '*'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $ServiceID = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Containers = Invoke-RancherApi -Path '/containers'
    $Containers = $Containers | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId -and $_.serviceIDs -like $ServiceID }

    if ($Raw) {
        $Containers
        return
    }

    $Containers | ForEach-Object {
        [pscustomobject]@{
            Name            = $_.name
            Environment     = $_.accountId
            Services        = $_.serviceIDs
            Id              = $_.id
            State           = $_.state
            HostID          = $_.HostID
            Uuid            = $_.uuid
            IpAddress       = $_.primaryIpAddress
            PSTypeName      = 'RancherContainer'
        }
    }
}