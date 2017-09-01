function Set-RancherServer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Server
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $AccessKey
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $SecretKey
    )

    $script:RancherServer    = $Server
    $script:RancherAccessKey = $AccessKey
    $script:RancherSecretKey = $SecretKey
}
