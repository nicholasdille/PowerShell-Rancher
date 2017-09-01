function Test-RancherServer {
    [CmdletBinding()]
    param()

    $script:RancherServer -and $script:RancherAccessKey -and $script:RancherSecretKey
}