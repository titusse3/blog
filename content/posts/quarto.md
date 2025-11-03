---
title: "Quarto"
date: "2025-04-28"
tags: [Raylib, C, Optimisation]
categories: [Raylib, C]
series : ["Themes Guide"]
math: true
ShowToc: true
---

Dans le cadre d’un projet universitaire, nous étions invités à développer une version numérique du jeu de plateau *Quarto*. Aux côtés de mon collègue [E. HADDAG](https://sagbot.com/), nous avons ainsi tenté de concevoir l’implémentation la plus performante à notre portée de ce jeu. L'intégralité 
de ce projet a été réalisée en *C* de l'interface à la mise en place du modèle.

<!--more-->

## Sommaire

Cet article se composera en trois parties :
1. [L'explication des règles du jeu.](#règles)
2. [Une présentation de l'implémentation de celui-ci.](#implémentation)
3. [La mise en place de l’interface graphique à l’aide de la librairie *C*, 
*Raylib*.](#Interface)

---

# Règles

Le jeu du *Quarto* se joue à deux joueurs sur un plateau **4×4**. Les deux 
joueurs ont à disposition **16 pièces**, toutes différentes. Chacune de ces 
pièces dispose de quatre caractéristiques dont les valeurs possibles sont les 
suivantes :

- **Couleur** : Rouge ou Bleu,
- **Forme** : Cylindrique ou Cubique,
- **Taille** : Grande ou Petite,
- **Type** : Pleine ou Creuse.

Les **16 pièces** sont donc toutes les combinaisons possibles de ces 
caractéristiques. L'image ci-dessous nous donne une représentation de ces 
pièces.

![Images des **16 pièces** du *Quarto*](https://i.imgur.com/bzjqcgQ.png)
*Image provenant d'un [document Universitaire sur le *Quarto*](https://math.univ-lyon1.fr/irem/IMG/pdf/Quarto.pdf).*

Une partie de jeu se déroule de la façon suivante :

1. Le joueur *Max* choisit une pièce qu'il offre à son adversaire. 
2. Le joueur *Min* place cette pièce sur le plateau et donne une seconde pièce dans celles restantes à *Max*. 
3. *Max* réitaire les opérations de *Min*. 

La partie se termine lorsque l'un des deux joueurs réussit à aligner quatre 
pièces comportant une **caractéristique commune**. La façon dont ont peu 
aligner les pièces sont celles données par l'image :

![Configuration gagnante dans le jeu.](https://i.imgur.com/1tdnuC5.png)
*Exemple de configurations gagnantes.*

Le joueur gagnant est celui qui pose la pièce qui amène à cet alignement. 
Cependant, il existe des configurations dans lesquelles aucun des deux joueurs 
n'est gagnant.

La configuration suivante ne permet à aucun des deux joueurs de réclamer la 
victoire :

![Exemple de configuration *nulle*](https://i.imgur.com/boXg7nC.png#center)
*Exemple de configuration *nulle* (aucun des deux joueurs ne gagne la partie).*

## Extension du jeu

Il a été prouvé par *Luc Goossens* sur [son site](https://web.archive.org/web/20041012023358/http://ssel.vub.ac.be/Members/LucGoossens/quarto/quartotext.htm) que le jeu du *Quarto* est un jeu *nulle*. C'est-à-dire que si les deux joueurs jouent à chaque fois les *meilleurs* couts, aucun des deux ne peut gagner.

Pour contrer ce problème, nous mettons en place une version du *Quarto* à 
quatre niveaux de jeu :

**Niveau 1** : configuration gagnante : celle classique. L'alignement de quatre pièces possédant une caractéristique commune.

<img src="https://i.imgur.com/PAlTDC1.png#center" width="175px" alt="Exemple de partie gagner dans le niveau 1"/>

*Exemple de partie gagnée dans le **niveau 1**. La couleur est la caractéristique commune.*

**Niveau 2** : configurations gagnantes : celle du niveau 1 ainsi qu'une disposition de quatre pièces aillant une caractéristique en commun dans un carré de largueur 2. 

<img src="https://i.imgur.com/YGBBY4C.png#center" width="175px" alt="Exemple de partie gagner dans le niveau 2"/>

*Exemple de partie gagnée dans le **niveau 2**. Le type (creuse) des quatre pièces est la caractéristique commune.*

**Niveau 3** : configurations gagnantes : celles des niveaux précédents ainsi que la disposition de quatre pièces (toujours avec une caractéristique commune) dans les coins d'un carré de largueur 3.

<img src="https://i.imgur.com/aCjfrns.png#center" width="175px" alt="Exemple de partie gagner dans le niveau 3"/>

*Exemple de partie gagnée dans le **niveau 3**. La hauteur (grande) des quatre pièces est la caractéristique commune.*

**Niveau 4** : configurations gagnantes : celles des niveaux précédents, ainsi que quatre pièces (toujours avec une caractéristique commune) formant soit un losange de largueur deux ou qu'elles soient dans les coins d'un losange de largueur 3.

<img src="https://i.imgur.com/eMG7YOr.png#center" width="400px" alt="Exemple de partie gagner dans le niveau 4"/>

*Exemple de deux parties gagnées dans le **niveau 4**. Que ce soit par la condition des coins ou encore du losange de largueur 3.*

---

# Implémentation

Tout le code associé à l'implémentation de la logique du jeu (et en aucun cas de l'interface) est décrit dans cette partie. L'intégralité de ce code est disponible sur le *Github* [quarto](https://github.com/titusse3/quarto).

## Représentation d'une partie de jeu

L'objectif de cette implémentation est d'être performante quant à son 
d'utilisation mémoires."
Cette contrainte est due à l'objectif d'utiliser cette implémentation par des algorithmes d'optimisation et de prise de décision dans un jeu. (MinMax, NégaMax ...).

### Les pièces

Il y a **16 pièces** dans ce jeu, chacune à **quatre attributs** ne pouvant prendre que deux valeurs. Nous avons donc décidé de représenter une pièce par un ensemble de 4 bit. Chaque bit représente une des quatre conditions suivantes :

- Est-ce que la pièce est marron ?
- Est-ce que la pièce est grande ?
- Est-ce que la pièce est creuse ?
- Est-ce que la pièce est un cube ?

Si la condition est vérifiée, alors le bit vaut *1*, *0* dans le cas contraire. Un exemple de telle représentation est donné par l'image ci-dessous :

<img src="https://i.imgur.com/8vhbWcm.png#center" width="400px" alt="Exemple de pièce selon la représentation sur 4 bits"/>

*Représentation de la petite pièce cylindrique marron qui est creuse selon notre représentation sur 4 bits.*

### Le plateau

Sur un plateau de *Quarto*, il y a **16 cases**. De plus, nous avons déjà une 
représentation des pièces sur 4 bits. Nous allons donc utiliser un entier de 
64 bits (\(16 \times 4 = 64\)) où chaque bloc de 4 bits représentera une case
de notre plateau de jeu. La première case sera la plus à gauche tandis que la 
dernière sera à droite.

![Représentation du plateau de jeu sur 64 bits](https://i.imgur.com/Nm6wh1h.png)
*Chaque case présente sur ce schéma est un groupe de 4 bits représentant une pièce.*

Avec cette implémentation, on se heurte à un problème. On ne peut pas 
représenter sur notre plateau l'absence de pièces sur une case. En effet, 
chaque combinaison possible sur les 4 bits est associée à une pièce. 
Pour résoudre ce problème, nous ajoutons donc un *résumé* de 16 bits. Chaque 
bit de ce *résumé* décrit la vacuité de la case de même indice.

![Exemple d'un résumer de plateau.](https://i.imgur.com/ioZlRkB.png)
*Par exemple, se résume à écrire un plateau qui n'admet des pièces qu'aux cases
d'indice 1, 3, 7 et 10.*

### L'état du jeu

Maintenant qu'on sait représenter les pièces et le plateau de jeu, il nous faut 
enregistrer quelques informations supplémentaires :

- Est-ce que la partie est finie ? 1 si oui, 0 sinon.
- À qui est-ce le tour ? 0 pour *Max* et 1 pour *Min*.
- Quelle pièce le joueur doit-il placer ? Descriptions de la pièce (toujours sur 4 bits).
- À quel tour sommes-nous ? nombre en 0 et 16 sur 5 bits.
- Sur quel niveau de difficulté le jeu se joue-t-il ? Sur deux bits
 - 00 : niveau 1
 - 01 : niveau 2
 - 10 : niveau 3
 - 11 : niveau 4

Pour cela, nous allons rajouter \(1 + 1 + 4 + 5 + 2 = 13\) bits. Nous obtenons 
donc comme représentation de ces informations de la manière suivante :

![Représentation de l'état de jeu sur 13 bits.](https://i.imgur.com/fREsn5L.png)

Ce qui nous donne une représentation finale :

![Représentation complète d'une partie de *Quarto*](https://i.imgur.com/Fz0k9OT.png#center)

Que nous représentons alors avec la structure suivante en *C* :

```c
struct quarto_t {
 uint32_t summary;
 uint64_t board;
};
```

## Récupération des informations

Pour interagir avec notre représentation, nous devons de ce faite utiliser les
opérateurs bit à bit fournis par le *C* :

| Opérateur | Descriptions                |
| --------- | ------------------------------------------ |
| ``~``   | Opération de négation d'un nombre binaire. |
| ``&``   | Et logique.                |
| ``\|``  | Ou logique.                |
| ``^``   | Ou exclusif (*xor*)            |

Nous allons parfois avoir besoin de la valeur d'un bit à une certaine position.
Notamment pour récupérer les valeurs dans le résumé. Prenons, par exemple, le
cas où nous voudrions récupérer le bit de la case 15 de notre *résumé*.

![Mise en évidence du bit rerpésentant la case 15 de notre plateau](https://i.imgur.com/yfEkXAd.png)

Sur les schémas depuis le début, nous avons représenté nos indices de la gauche
vers la droite, or en informatique, les nombres se lisent de la droite vers la
gauche. Ce qui implique que le bit d'indice 31 dans notre dessin correspond en
réalité au bit d'indice 0. On aura donc que l'opération
```c
printf("%b", quarto.summary & 1);
```
nous renvoie le bit d'indice 31 sur notre dessin.

Pour accéder à la valeur du bit recherché, il faut ainsi décaler (*shift*) cette
case le plus à droite possible. Après cela, il suffit d'appliquer un et logique
à ce bit et 1.

Il faut aussi se rappeler qu'en informatique, les nombres se lisent de droite à
gauche. Ainsi, pour récupérer le bit le plus à gauche, on devra faire plusieurs
décalages (*shift*) de sens pour amener le bit à droite de la même manière que
l'animation ci-dessous.

![*Gif* d'exemple de shift de façon récuprer une valeur à un certain indice](https://i.imgur.com/NpIoUUf.gif)

Pour rappel, les décalage en *C* se font dans les deux sens par les opérateurs suivants :

| Opérteur  | Descriptions                  |
| ---------- | ---------------------------------------------- |
| ``a >> b`` | Décale les bits de `a` de `b` case vers la droite. |
| ``a << b`` | Décale les bits de `a` de `b` case vers la gauche. |

Selon la norme 
 <a href="https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf">
  <i>C23</i>
 </a>, les bits ajoutés que ce soit à gauche ou à droite sont des zéros (outre
  le cas où le décalage est plus grand que la longueur du mot binaire)

## Écriture des informations

### Description des types

Pour simplifier les écritures de positionnement d'une pièce sur une certaine
case, nous avons donné à l'énumération `piece_t` et `position_t` des valeurs
particulières.

```c
typedef enum {
 // ...
 C1_HUGE_HOLE_SQUARE = 0b0110'0110'0110'0110'0110'0110'0110'0110'0110'0110'0110'0110'0110'0110'0110'0110,
 // ...
} piece_t;

typedef enum {
 // ...
 P3 = 0b0000'0000'0000'1111'0000'0000'0000'0000'0000'0000'0000'0000'0000'0000'0000'0000,
 // ...
} position_t;
```

Les notations ``0b`` ainsi que les caractères ``'`` dans la notation. Les 
binaires sont tous deux issus de la *C23*. La première permet d'écrire la valeur
au format binaire. La seconde correspond simplement à un séparateur améliorant
la lisibilité.

L'objectif étant de mettre en place une écriture/lecture d'une position du 
plateau de manière très rapide. Pour ce faire, on représente les positions 
(`position_t`) sur 64 bits. Pour qu'il soit de la même taille que le plateau. 
Ces bits sont tous à zéro seul le mot de quatre bits qui correspond à la case en
question admet ces bits à un.

De cette manière, pour récupérer la valeur de la pièce à la position 3 par 
exemple, il nous suffit de faire l'opération :

```c
quarto.board & P3;
```
De même pour l'écriture, il nous suffira d'effectuer l'opération :
```c
quarto.board |= C1_HUGE_HOLE_SQUARE & P3;
```
La raison pour laquelle l'écriture est si simple et que nous avons mis décris
le type `piece_t` comme une répétition de la valeur de pièce sur 64 bits. 
Pour qu'un simple et logique permette de modifier la valeur à cette case.

### Vérifications de fin de partie

Nous n'allons pas détailler toutes les fonctions permettant de vérifier chaque
condition de victoires selon les niveaux. En effet, une même logique est
appliquée dans chacune de ces fonctions (de nom `check__*`) ; seul le parcours
du plateau est différent.

Pour ce faire, on suppose que les quatre pièces que l'on souhaite tester sont
`[p1, p2, p3, p4]`. On commence par initialiser un accumulateur qui représentera
à chaque étape les points communs entre chaque pièce déjà traitée. Cet
accumulateur a donc la description suivante :

![Description de l'accumulateur.](https://i.imgur.com/kHRrICg.png)
*Exemple et description de l'accumulateur. Ici, les propriétés communes sont la 
taille et la forme.*

Maintenant, pour calculer les points communs entre deux pièces, il faut obtenir
les bits correspondant aux mêmes caractéristiques. On ne peut pas simplement
utiliser un et logique, par exemple, si nos deux pièces sont jaunes, leur
premier bit vaut toutes deux 0. Or, avec le et logique, nous aurions 0. Nous
avons donc besoin d'un opérateur aillant pour la table de vérité :

| a | b | Résultat |
| - | - | -------- |
| 0 | 0 | 1    |
| 0 | 1 | 0    |
| 1 | 0 | 0    |
| 1 | 1 | 1    |

Par ailleurs, on peut implémenter cette table par la formule `~(a ^ b)` (il 
s'agit de l'inverse d'un *ou exclusif*) en *C*. Il nous suffira alors 
d'effectuer un et logique entre cette valeur et la valeur actuelle de notre 
accumulateur.

À la fin de ces calculs, il nous suffit de regarder la valeur de l'accumulateur.
S'il vaut 0, il n'y a donc aucun point commun, sinon la partie est gagnée.

Comme évoqué précédemment, toutes les fonctions de tests utilisent ce procédé, 
seuls les algorithmes permettant de récupérer les pièces à comparer changent.

# Interface

Tout d'abord, le fond du jeu utilise le module `mbck` présenté dans l'article 
[*parallaxe_raylib*](/posts/parallaxe_raylib). Nous ne rentrerons pas dans les détails de 
l'implémentation *Raylib*. Il s'agit du premier gros projet que nous mettons en 
place avec celle-ci. De ce fait, le code a une qualité qui permet d'être 
instructif. 

Cette partie sert à faire une démonstration des fonctionnalités du jeu. Une 
image vaut mieux que mille mots, voici une vidéo qui démontre une partie des 
fonctionnalités disponibles. Si vous avez des retours sur ce jeu, merci de nous 
contacter.

<blockquote class="imgur-embed-pub" lang="en" data-id="1Hixjsh">
 <a href="https://imgur.com/1Hixjsh">View post on imgur.com</a>
</blockquote>
<script async src="//s.imgur.com/min/embed.js" charset="utf-8"></script>