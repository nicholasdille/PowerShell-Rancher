function Get-RancherCertificate {
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
        $CommonName = '*'
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

    $Certificates = Invoke-RancherApi -Path '/certificates'
    $Certificates = $Certificates | Where-Object { $_.id -like $Id -and $_.CN -like $CommonName -and $_.accountId -like $EnvironmentId }

    if ($Raw) {
        $Certificates
        return
    }
    
    $Certificates | ForEach-Object {
        [pscustomobject]@{
            Environment = $_.accountId
            Id          = $_.id
            CommonName  = $_.CN
            Fingerprint = $_.certFingerprint
            ExpiryDate  = $_.expiresAt
            SAN         = $_.subjectAlternativeNames
            Algorithm   = $_.algorithm
            KeySize     = $_.keySize
            State       = $_.state
            Uuid        = $_.uuid
            PSTypeName  = 'RancherCertificate'
        }
    }
}