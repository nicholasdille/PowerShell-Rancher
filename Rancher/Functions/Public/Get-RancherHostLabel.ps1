function Get-RancherHostLabel {
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
        $_.labels `
            | Add-Member -MemberType NoteProperty -Name 'Environment' -Value $_.accountId -PassThru `
            | Add-Member -MemberType NoteProperty -Name 'Host'        -Value $_.id -PassThru
    }
}