#requires -Version 4
#requires -Modules WebRequest

function Invoke-RancherApi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
        ,
        [Parameter()]
        [ValidateSet('Delete', 'Get', 'Post', 'Put')]
        [string]
        $Method = 'Get'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers = @{}
    )

    if (-not $Headers.ContainsKey('Accept')) {
        $Headers.Add('Accept', 'application/json')
    }

    $Rancher = Get-RancherServer

    $Next = "$($Rancher.Server)/v2-beta/$Path"
    $Data = @()

    $ConfiguredProtocols = [System.Net.ServicePointManager]::SecurityProtocol
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls11,Tls12'
    while ($Next) {
        $Response = Invoke-AuthenticatedWebRequest -Uri $Next -Method $Method -User $Rancher.AccessKey -Token $Rancher.SecretKey -Headers $Headers

        $Content = $Response.Content.Replace('"HTTP_PROXY="', '"http_proxy_uppercase="').Replace('"HTTPS_PROXY="', '"https_proxy_uppercase="').Replace('"NO_PROXY="', '"no_proxy_uppercase="')
        $Content = $Response.Content.Replace('"HTTP_PROXY"', '"http_proxy_uppercase"').Replace('"HTTPS_PROXY"', '"https_proxy_uppercase"').Replace('"NO_PROXY"', '"no_proxy_uppercase"')
        $Content = $Content | ConvertFrom-Json

        $Data += $Content.data

        $Next = $Content.pagination.next
    }
    [System.Net.ServicePointManager]::SecurityProtocol = $ConfiguredProtocols

    $Data
}