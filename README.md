| AppVeyor | Coveralls | Download |
| :------: | :-------: | :------: |
| [![Build status](https://ci.appveyor.com/api/projects/status/2fehm202bq6596jc?svg=true)](https://ci.appveyor.com/project/nicholasdille/powershell-rancher) | [![Coverage Status](https://coveralls.io/repos/github/nicholasdille/PowerShell-Rancher/badge.svg?branch=master)](https://coveralls.io/github/nicholasdille/PowerShell-Rancher?branch=master) | [![Download](https://img.shields.io/badge/powershellgallery-Rancher-blue.svg)](https://www.powershellgallery.com/packages/Rancher/)

# Introduction

Cmdlets for [Rancher](http://rancher.com/rancher/)

## Usage

```powershell
Install-Module -Name Rancher
Set-RancherServer -Server your_server_here.com -AccessKey your_access_key_here -SecretKey your_secret_key_here
Get-Command -Module Rancher
```
