if ($args.count -lt 5) {
	$scriptName = $MyInvocation.MyCommand.Name
	write-host "Utilisation:" $scriptName "<url racine du site sharepoint> <nom du site à créer> <répertoire à uploader> <owner email> <site email>"
	exit
}

#Config Variables
#$AdminSiteURL = "https://riousset.sharepoint.com"
$AdminSiteURL = $args[0]
$displayName = $args[1]
$folder = $args[2]
$owner = $args[3]
$mailNickname = $args[4]

$description = $displayName
 
Try {
	#Connect to PnP Online
	Connect-PnPOnline -Url $AdminSiteURL -Interactive
 
	#Create a new Office 365 group
	# New-PnPMicrosoft365Group -DisplayName $displayName -MailNickname "HRAdmin" -Owners $owner -Members @($owner) -IsPrivate
	$site = New-PnPMicrosoft365Group -DisplayName $displayName -Description $description -MailNickname $mailNickname -Owners $owner -Members @($owner) -IsPrivate 

	write-host ($site | Format-Table | Out-String)

	& "./upload.ps1" $site.SiteURL $folder
}
Catch {
    write-host -f Red "Error:" $_.Exception.Message
}

