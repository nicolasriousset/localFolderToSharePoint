if ($args.count -lt 3) {
	$scriptName = $MyInvocation.MyCommand.Name
	write-host "Utilisation:" $scriptName "<url racine du site sharepoint> <fichier csv> <owner email>"
	exit
}

# Autres paramètres pour le script migrate.ps1
$AdminSiteURL = $args[0]
$csvPath = $args[1]
$ownerEmail = $args[2]

# Lire le fichier CSV
$csv = Import-Csv -Path $csvPath –Delimiter ";"

write-host ("CSV chargé: " + $csvPath | Out-String)
# Pour chaque ligne dans le fichier CSV
foreach ($row in $csv) {
    # Récupérer l'URL du site à partir de la ligne actuelle    
    $siteEmail = "affaire-" + $row.psobject.properties.value[0]
    $localFolder = $row.psobject.properties.value[1]

    write-host ("Dossier: " + $localFolder | Format-Table | Out-String)

    # Appeler le script migrate.ps1 avec l'URL du site et les autres paramètres
    & "./migrate.ps1" $AdminSiteURL $localFolder d:\fieloux\$localFolder $ownerEmail $siteEmail
}