function Get-RancherAdmin {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id = '*'
    )

    Get-RancherAccount -Kind 'admin' | Where-Object { $_.id -like $Id } | Initialize-RancherUser -PSTypeName 'RancherAdmin'
}