function Get-RancherService {
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
        [switch]
        $Raw
    )

    $Services = Invoke-RancherApi -Path '/services'
    $Services = $Services | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId -and $_.stackId -like $StackId }
    
    if ($Raw) {
        $Services
        return
    }
    
    $Services | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Stack       = $_.stackId
            Id          = $_.id
            Name        = $_.name
            State       = $_.state
            Health      = $_.healthState
            Instances   = $_.instances
            Uuid        = $_.uuid
            PSTypeName  = 'RancherService'
        }
    }
}