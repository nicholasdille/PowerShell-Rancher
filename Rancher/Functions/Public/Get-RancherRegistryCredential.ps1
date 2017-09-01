function Get-RancherRegistryCredential {
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
        $RegistryId = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Credentials = Invoke-RancherApi -Path '/registrycredentials'
    $Credentials = $Credentials | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId -and $_.registryId -like $RegistryId }

    if ($Raw) {
        $Credentials
        return
    }
    
    $Credentials | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Registry    = $_.registryId
            Id          = $_.id
            PublicValue = $_.publicValue
            SecretValue = $_.secretValue
            State       = $_.state
            Uuid        = $_.uuid
            PSTypeName  = 'RancherRegistryCredential'
        }
    }
}