function Get-RancherLoadBalancerRule {
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

    $LoadBalancers = Invoke-RancherApi -Path '/loadbalancerservices'
    $LoadBalancers = $LoadBalancers | Where-Object { $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $LoadBalancers
        return
    }
    
    $LoadBalancers | ForEach-Object {
        $lb = $_

        $_.lbConfig.portRules | ForEach-Object {
            [pscustomobject]@{
                Environment  = $lb.accountId
                LoadBalancer = $lb.id
                Priority     = $_.priority
                Hostname     = $_.hostname
                Protocol     = $_.protocol
                Port         = $_.sourcePort
                Service      = $_.serviceId
                TargetPort   = $_.targetPort
                PSTypeName   = 'RancherLoadBalancerRule'
            }
        }
    }
}