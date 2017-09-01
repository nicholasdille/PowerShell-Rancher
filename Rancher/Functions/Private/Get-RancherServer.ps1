function Get-RancherServer {
    [CmdletBinding()]
    param()

    if (-Not (Test-RancherServer)) {
        throw 'Credentials not set. Please use Set-RancherServer first.'
    }

    @{
        Server    = $script:RancherServer
        AccessKey = $script:RancherAccessKey
        SecretKey = $script:RancherSecretKey
    }
}