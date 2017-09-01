function Get-RancherAccount {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet('admin', 'user', 'project', 'system', 'superadmin', 'token', 'service', 'agent')]
        [string]
        $Kind = '*'
    )

    Invoke-RancherApi -Path '/accounts' | Where-Object { $_.kind -like $Kind }
}