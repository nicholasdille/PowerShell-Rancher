function Get-RancherHost {
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
        [ValidateSet('active', 'inactive', 'reconnected', 'finishing-reconnect')]
        [string]
        $State = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Hosts = Invoke-RancherApi -Path '/hosts'
    $Hosts = $Hosts | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId -and $_.state -like $State }

    if ($Raw) {
        $Hosts
        return
    }
    
    $Hosts | ForEach-Object {
        [pscustomobject]@{
            Environment   = $_.accountId
            Id            = $_.id
            Name          = $_.hostname
            State         = $_.state
            Cores         = $_.milliCpu / 1000
            Storage       = $_.localStorageMb
            Driver        = $_.driver
            OS            = $_.data.fields.info.osInfo.operatingSystem
            StorageDriver = $_.engineStorageDriver
            Labels        = $_.labels.PSObject.Properties | ForEach-Object -begin { $hash = @{} } -process { $hash."$($_.Name)" = $_.Value } -end { $hash }
            Uuid          = $_.uuid
            PSTypeName    = 'RancherHost'
        }
    }
}