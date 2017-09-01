function Get-RancherSetting {
    [CmdletBinding()]
    param(
        [Parameter()]
        [switch]
        $Raw
    )

    $Secrets = Invoke-RancherApi -Path '/settings'

    if ($Raw) {
        $Secrets
        return
    }
    
    $Secrets | ForEach-Object {
        [pscustomobject]@{
            Id         = $_.id
            Type       = $_.type
            Name       = $_.name
            Source     = $_.source
            Value      = $_.value
            PSTypeName = 'RancherSetting'
        }
    }
}