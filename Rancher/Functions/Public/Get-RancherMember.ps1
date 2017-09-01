function Get-RancherMember {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $EnvironmentId = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Projects = Get-RancherAccount -Kind 'project'
    $Projects = $Projects | Where-Object { $_.id -like $EnvironmentId }

    if ($Raw) {
        $Projects
        return
    }
    
    $Projects | ForEach-Object {
        $EnvId = $_.id

        $_.members | ForEach-Object {
            [pscustomobject]@{
                Environment = $EnvId
                Account     = $_.externalId
                Role        = $_.role
                PSTypeName  = 'RancherMember'
            }
        }
    }
}