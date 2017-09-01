$script:RancherServer    = ''
$script:RancherAccessKey = ''
$script:RancherSecretKey = ''

Get-ChildItem -Path "$PSScriptRoot\Functions" -Filter '*.ps1' -Recurse | ForEach-Object {
    . "$($_.FullName)"
}