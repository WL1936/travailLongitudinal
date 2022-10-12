###
### importData(start, end, path = ".")
###
##
##  TODO: documentation
##
importData <- function(start, end, path = ".")
{
    ## Définir des nombres magiques: numéro des mois (après le premier).
    APR <- 3L
    NOV <- 10L

    ## Convertir les deux premiers arguments en dates.
    start <- as.Date(start)
    end <- as.Date(end)

    ## Extraire les numéros des mois des dates de début et de fin (ces
    ## données servent souvent).
    ##
    ## La manière la plus simple pour les obtenir consiste à passer
    ## par le type POSIXlt. L'élément $mon d'un objet POSIXlt est le
    ## nombre de mois APRÈS le premier, donc un nombre entre 0 et 11.
    start.mon <- as.POSIXlt(start)$mon
    end.mon <- as.POSIXlt(end)$mon

    ## TODO: valider les arguments

    ## Générer la suite des dates entre 'start' et 'end' qui identifie
    ## les mois à importer. La suite va de 'start' au mois de 'end'
    ## par bonds d'un mois. Le jour de ces dates n'est pas important.
    ##
    ## Il faut se prémunir contre la possibilité que 'start' soit le
    ## 31 du mois, auquel cas 'seq' va sauter au 1er du mois suivant
    ## pour les mois de moins de 31 jours. Astuce: ajouter un jour à
    ## la date de départ et soustraire ce jour après coup.
    dates <- seq(start + 1, by = "+1 month",
                 length.out = end.mon - start.mon + 1L) - 1

    ## TODO: importation des données
    ##
    ## J'ai déjà dans 'dates' une date pour chaque mois à importer. Je
    ## sais comment générer les noms des fichiers correspondants.
    ##
    ## Je crois qu'il y a trois cas à considérer: 1) début et fin dans
    ## le même mois; 2) début et fin dans des mois consécutifs;
    ## 3) début et fin dans des mois non consécutifs.
    ##
    ## ?? Le deuxième cas est-il simplement un cas spécial du
    ## troisième? À vérifier.
    ##
    ## J'ai pu terminer la fonction auxiliaire 'read.bixi' ci-dessous
    ## qui sert à importer un fichier de données.
}

###
### read.bixi(filename)
###
##  Importe un fichier de données BIXI uniformes d'historique des
##  déplacements.
##
##  Arguments
##
##  filename: chemin d'accès complet vers un fichier de données.
##
##  Valeur
##
##  Tableau de données de six colonnes:
##
##  start_date: date de début du déplacement ("Date");
##  emplacement_pk_start: code d'emplacement de départ ("factor");
##  end_date: date de fin du déplacement ("Date");
##  emplacement_pk_end: code d'emplacement d'arrivée ("factor");
##  duration_sec: durée du déplacement en secondes ("numeric");
##  is_member: membre BIXI ou utilisateur occasionnel ("factor").
##
##  Exemples
##
##  read.bixi("OD_2016-05u.csv")
##  read.bixi("data/OD_2016-05u.csv")
##
read.bixi <- function(filename)
{
    ## Terminer avec une erreur si le fichier n'existe pas.
    if (!file.exists(filename))
        stop(paste("file", filename, "does not exist"))

    ## Importer les données avec les bons types de colonnes. Selon
    ## ?read.table, l'utilisation de 'comment.char = ""' accélère le
    ## traitement.
    read.csv(filename,
             colClasses = c(start_date           = "Date",
                            emplacement_pk_start = "factor",
                            end_date             = "Date",
                            emplacement_pk_end   = "factor",
                            duration_sec         = "numeric",
                            is_member            = "factor"),
             comment.char = "")
}
