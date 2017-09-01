function Get-RancherEnvironment {
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

    $Projects = Get-RancherAccount -Kind 'project'
    $Projects = $Projects | Where-Object { $_.id -like $Id }

    if ($Raw) {
        $Projects
        return
    }
    
    $Projects | ForEach-Object {
        [pscustomobject]@{
            Id            = $_.id
            Name          = $_.name
            State         = $_.state
            Health        = $_.healthState
            Orchestration = $_.orchestration
            Uuid          = $_.uuid
            PSTypeName    = 'RancherEnvironment'
        }
    }
}