function Get-RancherSecret {
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

    $Secrets = Invoke-RancherApi -Path '/secrets'
    $Secrets = $Secrets | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $Secrets
        return
    }
    
    $Secrets | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Id          = $_.id
            State       = $_.state
            Name        = $_.name
            Uuid        = $_.uuid
            PSTypeName  = 'RancherSecret'
        }
    }
}