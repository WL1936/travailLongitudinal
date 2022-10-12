# Afin de permettre une segmentation efficace des fichiers .csv nécessaire à 
# l'élaboration de ce travail, il est nécessaire d'installer le package
# nommé  'readr' 'Rcpp' en faisant marcher cette commande:

install.packages("readr")
installed.packages("Rcpp")

read.csv(OD)

summary(OD_2020_04u)
mean(OD_2020_04u$end_date)-mean(OD_2020_04u$start_date)
matrix(OD_2020_04u)