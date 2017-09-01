@{
    RootModule = 'Rancher.psm1'
    ModuleVersion = '0.1'
    GUID = '3ed0975c-c323-4293-95ad-d9dff2ca433a'
    Author = 'Nicholas Dille'
    #CompanyName = ''
    Copyright = '(c) 2017 Nicholas Dille. All rights reserved.'
    # Description = ''
    # PowerShellVersion = ''
    # RequiredModules = @()
    FunctionsToExport = '*'
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    FormatsToProcess = @(
        'RancherAdmin.Format.ps1xml'
        'RancherCertificate.Format.ps1xml'
        'RancherEndpoint.Format.ps1xml'
        'RancherEnvironment.Format.ps1xml'
        'RancherHost.Format.ps1xml'
        'RancherInstance.Format.ps1xml'
        'RancherLoadBalancer.Format.ps1xml'
        'RancherLoadBalancerRule.Format.ps1xml'
        'RancherMember.Format.ps1xml'
        'RancherMount.Format.ps1xml'
        'RancherPort.Format.ps1xml'
        'RancherRegistry.Format.ps1xml'
        'RancherRegistryCredential.Format.ps1xml'
        'RancherSecret.Format.ps1xml'
        'RancherService.Format.ps1xml'
        'RancherSetting.Format.ps1xml'
        'RancherStack.Format.ps1xml'
        'RancherUser.Format.ps1xml'
        'RancherVolume.Format.ps1xml'
    )
    PrivateData = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # ReleaseNotes = ''
        }
    }
}

