# Traitement du signal bidimensionnel

Ce répertoire contient les codes sources MATLAB des TPs de de Traitement du Signal Bidimensionnel au programme des 2ème année de Télécom Physique Strasbourg pour les I2S. Consiste en l'analyse des imaes par les techniques classiques de traitement du signal.

## TP1: Affichage, TF et Masque

Objectifs :

- Affichage d'une image
- Inverser une image
- Amplitude de la TF d'une image
- Phase de la TF d'une image
- Filtrage d'une image par un masque

![tp1](tp1.png)

Les deux dernières images montrent l'effet d'un passe bas sur une image. Appliquer un filtre passe-bas à l'image revient à convoluer par la fonction de transfert passe-bas dans le domaine réel et revient à multiplier par un masque qui laisse passer les basses fréquences et tue les hautes fréquences. On peut voir que l'imagereconstruite à partir de la nouvelle transformée de Fourier est floutée.

## TP2: Débruitage

Objectfis :

- Débruiter une image par filtrage dans le domaine fréquentiel
- Construire des masques de filtrage complexes

![tp2](house.png)

Le filtrage de l'image `house.png` est effectué par une masque passe-bas sur le cadre visible de bruit blanc dans la transformée de Fourier. On peut voir que l'image reconstruite est moins bruitée.

![tp2_2](cameraman_textured.png)

La construction du masque pour filtrer l'imege `cameraman_textured.png` est plus complexe. On doit construire un masque qui doit filtrer les pixels de la transformée de Fourier de la texture qui sont en surbrillance. Il a donc fallu construire un pré-masque avec un seuil pour les pixels de la transformée de Fourier qui sont en surbrillance. Ensuite, on a construit un masque qui laisse passer les très basses fréquences qui contiennent les informations de la couleur. On peut voir que l'image reconstruite est moins bruitée.

![tp2_3](debruitee.png)

## TP3: Compression
