function Initialize-RancherUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [pscustomobject]
        $InputObject
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $PSTypeName
    )

    process {
        foreach ($Item in $InputObject) {
            $UserHash = @{
                Id         = $Item.id
                Name       = $Item.name
                State      = $Item.State
                Uuid       = $Item.uuid
            }
            
            If ($PSTypeName) {
                $UserHash.Add('PSTypeName', $PSTypeName)
            }

            [pscustomobject]$UserHash
        }
    }
}