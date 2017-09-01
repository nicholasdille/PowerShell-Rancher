function Get-RancherRegistry {
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
        $Address = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Registries = Invoke-RancherApi -Path '/registries'
    $Registries = $Registries | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId -and $_.serverAddress -like $Address }

    if ($Raw) {
        $Registries
        return
    }
    
    $Registries | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Id          = $_.id
            State       = $_.state
            Address     = $_.serverAddress
            Uuid        = $_.uuid
            PSTypeName  = 'RancherRegistry'
        }
    }
}