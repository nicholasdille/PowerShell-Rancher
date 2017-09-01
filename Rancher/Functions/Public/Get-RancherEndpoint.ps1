function Get-RancherEndpoint {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $EnvironmentId = '*'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $HostId = '*'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Port = '*'
        ,
        [Parameter()]
        [switch]
        $Raw
    )

    $Hosts = Invoke-RancherApi -Path '/hosts'
    $Hosts = $Hosts | Where-Object { $_.accountId -like $EnvironmentId -and $_.port -like $Port }

    if ($Raw) {
        $Hosts
        return
    }
    
    $Hosts | Where-Object { $_.id -like $HostId } | ForEach-Object {
        $HostId = $_.id
        $Environment = $_.accountId

        $_.publicEndpoints | ForEach-Object {
            [pscustomobject]@{
                Environment = $Environment
                Host        = $HostId
                IPAddress   = $_.ipAddress
                Port        = $_.port
                Service     = $_.serviceId
                Instance    = $_.instanceId
                PSTypeName  = 'RancherEndpoint'
            }
        }
    }
}