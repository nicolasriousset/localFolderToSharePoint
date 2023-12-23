# Chemin vers le répertoire
$repertoire = $args[0]

# Chemin vers le fichier CSV de sortie
$csvSortie = $args[1]

# Obtenir tous les dossiers dans le répertoire
$dossiers = Get-ChildItem -Path $repertoire -Directory

# Créer un tableau pour stocker les noms des dossiers
$nomsDossiers = @()

# Pour chaque dossier dans le répertoire
foreach ($dossier in $dossiers) {
    # Ajouter le nom du dossier au tableau
    $nomsDossiers += New-Object PSObject -Property @{Nom = $dossier.Name}
}

# Écrire les noms des dossiers dans le fichier CSV
$nomsDossiers | Export-Csv -Path $csvSortie -NoTypeInformation