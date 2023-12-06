# Upload file to site
# https://theitbros.com/powershell-upload-file-to-sharepoint/#penci-Install-the-PnP-PowerShell-Module

if ($args.count -lt 2) {
	$scriptName = $MyInvocation.MyCommand.Name
	write-host "Utilisation:" $scriptName "<url racine du site sharepoint> <répertoire à uploader>"
	exit
}

# What is the target SharePoint site URL for the upload? 
# $spoSite = 'https://riousset.sharepoint.com/sites/HRAdmin2/' 
$spoSite = $args[0] 

# What is the location of the files to upload? 
$localFolder = $args[1]

# What is the target document library relative to the site URL? 
$spoDocLibrary = "Documents partages"

Connect-PnPOnline -Url $spoSite -Interactive

Get-PnPSite

function Upload-Folder {
	param (
        	$localFolder,
        	$remoteFolder
    	)

    Write-host 'Uploading folder' $localFolder.toString() ' to ' $remoteFolder.toString()

    $resolvedRemoteFolder = Resolve-PnPFolder -SiteRelativePath $remoteFolder


    $files = Get-ChildItem $localFolder -File

    foreach ($file in $files) { 
        write-host 'Uploading file ' $file.FullName.ToString()
	$uploadedFile = Add-PnPFile -Path ($file.FullName.ToString()) -Folder $remoteFolder -Values @{"Title" = $($file.Name) } 
    }

    $subfolders = Get-ChildItem $localFolder -Directory
    foreach ($subfolder in $subfolders) { 
	$folderName = Split-Path $subfolder.FullName -Leaf
        Upload-Folder -localFolder $subfolder.FullName -remoteFolder "$remoteFolder/$folderName/"
    }

}


Upload-Folder -localFolder $localFolder -remoteFolder $spoDocLibrary