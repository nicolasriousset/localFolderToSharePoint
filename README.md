# localFolderToSharePoint

A set of PowerShell Scripts, relying on Pnp Powershell modules, to automate creation of a SharePoint Teams Site, and upload of files to this site document library from a local folder.

# Requirements
PowerShell 7 mmust be installed : https://lazyadmin.nl/powershell/update-powershell/
Pnp PowerShell modules must be installed : https://pnp.github.io/powershell/articles/installation.html

# How to run ?
From your powershell command executor, run :

.\migrate.ps1 https://contoso.sharepoint.com 'Business Case 123' '.\Business Case 123\' owner@contoso.onmicrosoft.com case-123
