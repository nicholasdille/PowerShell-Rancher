function Get-RancherStack {
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

    $Stacks = Invoke-RancherApi -Path '/stacks'
    $Stacks = $Stacks | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $Stacks
        return
    }
    
    $Stacks | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Id          = $_.id
            Name        = $_.name
            State       = $_.state
            Health      = $_.healthState
            Services    = $_.serviceIds
            Uuid        = $_.uuid
            PSTypeName  = 'RancherStack'
        }
    }
}