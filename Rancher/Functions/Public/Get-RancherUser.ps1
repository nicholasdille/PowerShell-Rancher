function Get-RancherUser {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id = '*'
    )

    Get-RancherAccount -Kind 'user' | Where-Object { $_.id -like $Id } | Initialize-RancherUser -PSTypeName 'RancherUser'
}