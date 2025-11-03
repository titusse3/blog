---
title: "Extraction d'information sur image (Chest-Reco)"
date: "2025-10-27"
tags: [Python, Automatisation]
ShowToc: true
---

Le jeu **Garry's Mod** est une plateforme qui propose de nombreux *mini jeux*.  
Cet article présente la mise en place d’un système d’**extraction  d’informations** à partir de plusieurs **captures d’écran** d’un coffre du jeux *naruto RP*, afin de connaître automatiquement le contenu de ce coffre.  

Cet article expliquera en détail la mise en place de ce projet Python, disponible sur GitHub : [dépôt GitHub](https://github.com/titusse3/chest-reco).

## Objectif du projet

L’objectif est d’automatiser l’analyse visuelle des coffres à l’aide d’un  
script *Python*. Ce projet met en œuvre des techniques de **traitement   d’image** et d’**extraction de texte**, tout en gardant à l’esprit la  nécessité de concevoir une solution légère et peu consommatrice en ressources.

## Code source

Le projet complet est disponible sur **GitHub** :
[dépôt GitHub du projet](https://github.com/titusse3/chest-reco)

## Description du problème

Dans le mini jeu *Naruto RP*, il existe des coffres dans lesquels il est  possible de stocker des ressources.

Très rapidement, une question se pose : *combien d’éléments ai-je actuellement dans mon coffre* ?  

Comme aucune *API* n’est disponible, l’objectif de ce mini projet est de  récupérer automatiquement le contenu d’un coffre à partir de captures  d’écran.  

### Exemple de coffre

Voici à quoi ressemble le contenu complet d’un coffre :  

![Exemple de contenu du coffre](https://i.imgur.com/AWLVAeL.gif#center)


## Fragmentation du problème

Le problème a été découpé de la manière suivante :  

1. **Extraction** d’une sous partie de l’image contenant les informations    pertinentes.  
2. **Récupération** du nombre présent sur la zone extraite.  
3. **Vérification** des données obtenues et mise en forme du résultat.  

L’objectif final est que **toutes les informations soient extraites  automatiquement**, sans nécessiter aucune interaction humaine.

# Architecture du projet

L’architecture de ce projet s’inspire de plusieurs blogs et documentations  techniques. Elle suit une structure **standard** recommandée par [*pyproject*](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/).  

```
.
├── src/
│   ├── modules1/
│   ├── ...
│   ├── modulesN/
│   ├── ressources/
│   └── main.py
└── tests/
    ├── integration_tests/
    └── unit_tests/
```

Cette organisation permet d’exécuter chaque test depuis n’importe quel  emplacement tout en gardant un accès direct aux modules à tester.  Pour cela, des fichiers `__init__.py` sont présents dans les dossiers de  tests afin d’ajuster correctement le chemin d’import des modules.

### Organisation des fichiers de test

```
tests/
    ├── integration_tests/
    │   ├── __init__.py
    |   └── ...
    └── unit_tests/
        ├── __init__.py
        └── ...
```

Le contenu de ces fichiers `__init__.py` :

```
# __init__.py

import sys
from os.path import dirname, join, normpath

THIS_DIR = dirname(__file__)
PROJ_DIR = normpath(join(THIS_DIR, '..', '..', 'src'))
```

Grâce au module `os.path`, le répertoire d’exécution est fixé à celui où se  trouvent les *sources*. Cela permet d’importer facilement toutes les  dépendances nécessaires, sans configuration complexe.

# Extraction des items

L’objectif, pour chaque objet donné, est d’extraire la partie de l’image représentant cet objet, à condition que celui ci soit bien présent dans  l’image.  

Pour cela, le module  [`opencv`](https://opencv.org/) est utilisé. Elle permet de **rechercher une “template”** à l’intérieur d’une image, sans aucune **ia**.   

Voici un exemple simple : une recherche de pièces a été effectuée sur  l’image de gauche. Le résultat, visible à droite, montre les correspondances  encadrées en rouge.

![Exemple d’utilisation d’OpenCV](https://i.imgur.com/pgQ9LMu.jpeg#center)  
*Image tirée de la documentation officielle d’OpenCV.*

## Contrainte de l'extraction

Tout d'abord, il est essentiel que le motif utilisé ait les mêmes dimensions que ses occurrences possibles dans l’image à analyser.

Cette contrainte a forcé l’application à adopter des dimensions spécifiques pour les images d'entrée. Les *captures d’écran* du contenu du coffre doivent donc être uniformisées, ici au format `1920x1080`.  

Pour les images ne respectant pas cette dimension, un traitement via `OpenCV` permet de les redimensionner, assurant ainsi une cohérence entre toutes les entrées.

## Mise en place de l'extraction d'objet

Prenons par exemple l’extraction *des planches de bois*, donnée par l’image :

![Image de planche de bois](https://i.imgur.com/bmqBWEH.jpeg#center)

Ici, on peut voir qu’il y a le nombre de cet objet en haut à droite, ce qui sera le cas pour n’importe quel autre objet.
Cependant, lorsque l’on souhaite rechercher combien de *planches de bois* il y a dans l’image, nous devons rechercher l’objet *planches de bois* sans ce nombre.
C’est pour cela que le *template* recherché sera l’image de l’objet seul, sans le nombre.
Typiquement, pour la planche de bois, il s’agira de l’image suivante :

![Template de l'objet, planche de bois](https://i.imgur.com/57bMFvd.png#center)

Une fois ce *template* obtenu, on peut assez simplement rechercher l’objet dans l’image d’un coffre à l’aide du code Python ci-dessous :

```py
import cv2

# Le pourcentage minimal de ressemblance souhaité entre la détection et le template
DEFAULT_TEMPLATE_MATCHING_THRESHOLD = 0.8

def main():
    img = cv2.imread("coffre.jpg")  # Image du coffre
    template = cv2.imread("item.png")  # Image du template (ex: planche de bois)
    template_height, template_width = template.shape[:2]

    template_matching = cv2.matchTemplate(template, img, cv2.TM_CCOEFF_NORMED)
    _, max_val, _, max_loc = cv2.minMaxLoc(template_matching)

    if max_val >= DEFAULT_TEMPLATE_MATCHING_THRESHOLD:
        x, y = max_loc
        detection = {
            "TOP_LEFT_X": x,
            "TOP_LEFT_Y": y,
            "BOTTOM_RIGHT_X": x + template_width,
            "BOTTOM_RIGHT_Y": y + template_height,
            "MATCH_VALUE": max_val
        }

        x1, y1 = detection["TOP_LEFT_X"], detection["TOP_LEFT_Y"]
        x2, y2 = detection["BOTTOM_RIGHT_X"], detection["BOTTOM_RIGHT_Y"]

        cv2.rectangle(img, (x1, y1), (x2, y2), (0, 0, 255), thickness=2)
        cv2.imshow("Detection", img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
    else:
        print("Aucune correspondance trouvée.")

if __name__ == "__main__":
    main()
```

On obtient alors, sur un coffre, le résultat suivant :

![Résultat de la recherche](https://i.imgur.com/CAlwlTU.jpeg#center)

Une fois l’objet trouvé, il suffit d’ajouter un offset de hauteur d’environ 45 pixels pour inclure le nombre associé.
Grâce à cela, il devient assez simple de récupérer à la fois l’objet et sa quantité en une seule image.

# Extraction du nombre

Pour la quantité d’un objet, il existe deux cas :
- La quantité est égale à 1 ; dans ce cas, aucune quantité n’est affichée.

![Image de planche de bois](https://i.imgur.com/hBwj3f0.png#center)

- La quantité est supérieure ou égale à 2 ; dans ce cas, la quantité est affichée sous la forme `x` suivie du nombre correspondant.

![Image de planche de bois](https://i.imgur.com/bmqBWEH.jpeg#center)

L’objectif, afin de rendre la reconnaissance du nombre aussi simple que possible, est d’extraire la quantité lorsqu’elle est présente dans l’image.
Pour cela, on effectue une nouvelle recherche de template dont le modèle est le caractère `x` placé avant le nombre.
Si le `x` n’est pas trouvé, alors l’objet est présent en un seul exemplaire.
Dans le cas contraire, on extrait le nombre de l’image à partir du `x` détecté,
en ajoutant un *offset* comme précédemment.

Ce qui nous donne, dans notre cas :

<img src="https://i.imgur.com/NQDf7lK.png" alt="Résultat de l'extraction du nombre" width="250" style="display:block;margin:0 auto;" />

Une fois cette partie extraite, on obtient une image contenant uniquement le nombre, que l’on peut transmettre à un modèle de reconnaissance de texte.
Ce projet utilise `easyocr`, un module de reconnaissance de texte sur image.
Après quelques prétraitements, notamment la correction des symboles `1`
souvent reconnus comme des `l` à cause de la police d’écriture,
on peut finalement identifier correctement le nombre affiché.

# Traitement final

Un coffre étant représenter par plusieur capture de celui-ci, un traitement multi-thread est mis en place. Pour chaqu'une des images, une recherche des tous les items possible est faite avec la `pipeline` suivante :

1. **Détection des objets**
   À l’aide de la recherche de *template* (`cv2.matchTemplate`), on identifie la présence des objets (ex. : planches de bois) dans l’image du coffre.

2. **Extraction du nombre associé**
   Une fois l’objet trouvé, une nouvelle recherche est effectuée pour détecter le symbole **`x`** précédant la quantité.
   Si ce symbole est présent, la portion d’image correspondante au nombre est extraite.

3. **Reconnaissance du nombre**
   L’image extraite du nombre est ensuite transmise à `easyocr`, un module de reconnaissance de texte.
   Après quelques prétraitements (notamment la correction des `1` mal reconnus comme `l`), on obtient la quantité exacte de l’objet.

Une vérification finale est mise en place afin de s’assurer qu’aucun item n’a été détecté sur plusieurs images différentes.
Si c’est le cas et que les deux quantités diffèrent, une erreur est levée.
Dans le cas contraire, le duplicat est supprimé.
