function Get-RancherLoadBalancer {
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
        [switch]
        $Raw
    )

    $LoadBalancers = Invoke-RancherApi -Path '/loadbalancerservices'
    $LoadBalancers = $LoadBalancers | Where-Object { $_.id -like $Id -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $LoadBalancers
        return
    }
    
    $LoadBalancers | ForEach-Object {
        $Certificates = @()
        if ($_.lbConfig.defaultCertificateId) {
            $Certificates += $_.lbConfig.defaultCertificateId
        }
        $Certificates += $_.lbConfig.certificateIds

        [pscustomobject]@{
            Environment  = $_.accountId
            Id           = $_.id
            Name         = $_.name
            State        = $_.state
            Scale        = $_.currentScale
            FQDN         = $_.fqdn
            Certificates = $Certificates
            Instances    = $_.instances
            Uuid         = $_.uuid
            PSTypeName   = 'RancherLoadBalancer'
        }
    }
}