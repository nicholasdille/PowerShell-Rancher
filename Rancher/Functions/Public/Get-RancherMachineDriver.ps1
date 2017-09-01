function Get-RancherMachineDriver {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Hosts = Invoke-RancherApi -Path '/machinedrivers'
    $Hosts = $Hosts | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $Hosts
        return
    }
    
    $Hosts | ForEach-Object {
        [pscustomobject]@{
            Id            = $_.id
            Name          = $_.name
            State         = $_.state
            Uuid          = $_.uuid
            PSTypeName    = 'RancherMachineDriver'
        }
    }
}