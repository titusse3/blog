---
title: "Fond Parallaxe"
date: "2025-02-24"
tags: [Raylib, C]
series : ["Themes Guide"]
---

Après avoir consulté 
l'[exemple](https://github.com/michenriksen/til-example-site/blob/main/content/posts/rich-content.md) 
dédié au **défilement parallaxe** de la *Raylib*, j'ai décidé de créer un module 
en **C** pour rendre son implémentation plus propre et efficace (toujour à 
l'aide de la *Raylib*), 
**[lien vers le repertoire du module](https://github.com/titusse3/mbck)**.

<!--more-->

## Principe d'un fond parallaxe

Le concept de fond en **parallaxe** consiste à faire défiler des images selon un 
décalage différent. Autrement dit, deux couches – le *background* et le 
*foreground* – sont décalées à des vitesses variées pour créer une illusion de 
profondeur et de mouvement continu. Une image vaut mieux que mille mots (un 
*gif* dans ce cas) :

![Image d'exemple](https://i.imgur.com/OWcwcoW.gif#center)
*Exemple tiré de [Wikipédia](https://en.wikipedia.org/wiki/Parallax_scrolling)*

## Principe d'Implémentation

Contrairement à ce que j'imaginais, il n'est pas nécessaire d'utiliser une seule 
image de très grande taille pour obtenir cet effet. En réalité, répéter 
plusieurs fois la même image permet de créer l'illusion d'un fond continu.

### Fond simple

Pour mettre en place ce mécanisme, on dispose de deux copies de notre fond, 
placées côte à côte. Comme on peut le voir dans l'animation ci-dessous, la 
première copie présente un bord vert tandis que la seconde affiche un bord 
violet. Le rectangle bleu représente l'écran de l'utilisateur (celui qui observe 
notre fond *parallax*). On déplace ensuite les deux images de gauche à droite 
et, dès que le bord droit de la seconde image est atteint, le décalage est 
réinitialisé.

![Exemple de parallax](https://i.imgur.com/FF3KQ11.gif#center)  
*L'image de fond utilisée est celle de 
[Edermunizz](https://edermunizz.itch.io/)*

Je me suis permis de qualifier cette version de fond *simple*, car l'image 
utilisée se prolonge continuellement vers la droite. En effet, le motif obtenu 
en plaçant côte à côte la même image est continu, ce qui facilite son 
implémentation. Cependant, ce type de fond n'est pas le plus courant ; il était
donc nécessaire de prévoir une version alternative capable d'utilisé des images 
ne possédant pas cette propriété.

### Fond difficile

Comme expliqué précédemment, certaines images, comme celle-ci, ne se prêtent pas 
à une simple répétition.

![Exemple de mise côte à côte d'une image qui ne fonctionne pas](https://i.imgur.com/yIyDjcy.png#center)  
*Magnifique croquis de Mayotte, réalisé par moi-même*

Pour remédier à ce problème, l'idée consiste à effectuer une rotation 
horizontale de la seconde image. Ce *flip* permet de créer une continuité dans 
le motif.

![Démonstration de la continuité du fond par un flip](https://i.imgur.com/f9WsCRU.png)

On pourrait alors penser qu'il suffirait d'appliquer la méthode décrite dans la 
section précédente pour animer le fond. Cependant, cela ne fonctionne pas : il 
manque une partie du motif, ce qui engendre une sensation de téléportation lors 
du décalage. Pour mieux illustrer ce problème, observons une version montrant le 
mouvement complet du fond.

![Exemple fond complet de l'image](https://i.imgur.com/NedrC3V.png)

À l'aide de cette image, identifiez la zone problématique de notre première 
implémentation. Il s'agit de la zone de transition entre la deuxième et la 
troisième image, mise en évidence par la teinte violette sur l'image ci-dessous.

![Exemple de la zone de transition (partie violette)](https://i.imgur.com/uVGOtTU.png)

En effet, en appliquant l'implémentation précédente, la réinitialisation des 
deux images provequera un effet de téléportation visuelle de notre fond.
Si vous n'êtes toujours pas convaincu, voici un *gif* illustrant notre 
implémentation précédente.

![Exemple *gif* avec implémentation précédente](https://i.imgur.com/KY8VPzE.gif)

On constate explicitement, à l'écran de l'utilisateur (représenté par le 
rectangle bleu), l'île n'est jamais affichée dans son intégralité. Une 
transition brutale se produit, où le début de l'île apparaît subitement à 
droite, remplaçant la partie gauche.

Pour résoudre ce problème, ajouter seulement une troisième image. Cette 
troisième image permet de revenir au premier cas, où l'image de départ est 
identique à celle utilisée lors de la réinitialisation. Pour s'en mettre 
d'accord, il suffit de regarder l'image ci-dessus qui représenter un mouvement 
complet de notre motif.

Par ailleurs, dans les deux exemples présentés — que ce soit avec l'utilisation 
d'une image *simple* ou d'une image plus *difficile* — j'ai opté pour un 
mouvement de gauche à droite, bien que l'inverse aurait également pu être 
envisagé. Le module offre ainsi la possibilité de personnaliser les paramètres
de flip si nécéssaire ainsi que la direction du mouvement.

## Mise en place du module

Comme dans tout module **C** bien conçu, une seule structure, `mbck_t` (*moving 
background type*), est exposée à l'utilisateur. Celle-ci regroupe toutes les 
informations nécessaires à la configuration et à l'affichage du fond, à savoir 
la largeur et la hauteur de la fenêtre ainsi que le vers l'image de fond.

L'élément central de ce module est la fonction `mbck_physics_process`, qui doit 
être appelée à chaque frame. En effet, elle se charge simultanément d'afficher 
le fond et de l'animer. Dans cette fonction, l'affichage des textures est 
réalisé (deux pour une image *simple*, trois dans le cas contraire) en 
appliquant un offset correspondant au mouvement.

Pour mettre en place ce mouvement, un compteur nommé `scroll_b` est intégré à la 
structure. Ce compteur représente le décalage des images par rapport à l'écran 
de l'utilisateur et est modifié par le paramètre `delta` passé à 
`mbck_physics_process`. Si `delta` est négatif, le fond se déplace de droite à 
gauche (l'offset est décrémenté), tandis que pour une valeur positive, le 
mouvement est inversé.

Enfin, comme illustré dans les exemples précédents, la remise à zéro du fond 
intervient lorsque le décalage fait disparaître la première (ou la seconde, 
selon le sens du mouvement) image de la fenêtre.

### Conclusion

Grâce à ce module simple, en combinant plusieurs instances de la 
structure `mbck_t`, il est possible de créer des animations de fond d'une grande 
qualité. De plus, une multitude d'images destinées à ce type de fond sont 
disponibles sur des sites comme [itch.io](https://itch.io/). Par exemple, j'ai 
pu y trouver des *layers* qui composent le fond présenté en exemple dans ce 
module :

![Exemple avec plusieurs layers du module](https://i.imgur.com/YMzI9Qv.gif)
*Auteur des Layers utilisé [CraftPix](https://www.youtube.com/channel/UCW6u-uvdYt5ub0zsZDAHXKw)*