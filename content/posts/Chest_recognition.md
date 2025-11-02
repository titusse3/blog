---
title: "Extraction d'information sur image (Chest-Reco)"
date: "2025-10-27"
tags: [Python, Automatisation]
ShowToc: true
---

Le jeu **Garry's Mod** est une plateforme qui propose de nombreux *mini jeux*.  
Cet article présente la mise en place d’un système d’**extraction  
d’informations** à partir de plusieurs **captures d’écran** d’un coffre du jeux *naruto RP*, afin de connaître automatiquement le contenu de ce coffre.  

Cet article expliquera en détail la mise en place de ce projet Python, disponible sur GitHub : [dépôt GitHub](https://github.com/titusse3/chest-reco).

## 🧠 Objectif du projet

L’objectif est d’automatiser l’analyse visuelle des coffres à l’aide d’un  
script **Python**. Ce projet met en œuvre des techniques de **traitement  
d’image** et d’**extraction de texte**, tout en gardant à l’esprit la  
nécessité de concevoir une solution **légère et peu consommatrice en  
ressources**.

## 💻 Code source

Le projet complet est disponible sur **GitHub** :
[dépôt GitHub du projet](https://github.com/titusse3/chest-reco)

## 🧩 Description du problème

Dans le mini jeu *Naruto RP*, il existe des **coffres** dans lesquels il est  
possible de **stocker des ressources**. Ces ressources servent ensuite à  
**construire d’autres éléments**.  

Très rapidement, une question se pose : *combien d’éléments puis je créer  
avec le contenu actuel de mon coffre* ?  

Comme **aucune API n’est disponible**, l’objectif de ce mini projet est de  
**récupérer automatiquement le contenu d’un coffre** à partir de **captures  
d’écran** qui le représentent.  

### 📸 Exemple de coffre

Voici à quoi ressemble le contenu complet d’un coffre :  

![Exemple de contenu du coffre](https://i.imgur.com/AWLVAeL.gif#center)


## 🧠 Fragmentation du problème

Le problème a été découpé de la manière suivante :  

1. **Extraction** d’une sous partie de l’image contenant les informations  
   pertinentes.  
2. **Récupération** du nombre présent sur la zone extraite.  
3. **Vérification** des données obtenues et **mise en forme** du résultat.  

L’objectif final est que **toutes les informations soient extraites  
automatiquement**, sans nécessiter **aucune interaction humaine**.

# 🧱 Architecture du projet

L’architecture de ce projet s’inspire de plusieurs blogs et documentations  
techniques. Elle suit une structure **standard** recommandée par  
[*pyproject*](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/).  

Les différents **modules** ainsi que l’**application principale** se  
trouvent dans le dossier `src`, tandis que les **tests** sont séparés en  
**tests unitaires** et **tests d’intégration** dans le dossier `tests`.  
Le framework de test utilisé est **pytest**.  

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

Cette organisation permet d’exécuter chaque test depuis n’importe quel  
emplacement tout en gardant un accès direct aux modules à tester.  
Pour cela, des fichiers `__init__.py` sont présents dans les dossiers de  
tests afin d’ajuster correctement le chemin d’import des modules.

### 🧩 Organisation des fichiers de test

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

Grâce au module `os.path`, le répertoire d’exécution est fixé à celui où se  
trouvent les **sources**. Cela permet d’importer facilement toutes les  
dépendances nécessaires, sans configuration complexe.

# 🧩 Extraction des items

Dans le jeu, il existe actuellement **48 items** pouvant être utilisés pour  
créer un peu plus de **17 équipements**.  
L’objectif, pour chaque objet donné, est d’**extraire la partie de l’image**  
représentant cet objet, à condition que celui ci soit bien présent dans  
l’image.  

Pour cela, j’ai choisi d’utiliser le module  
[`opencv`](https://opencv.org/). Cette bibliothèque très complète permet,  
entre autres fonctionnalités, de **rechercher une “template”** (un modèle  
d’image) à l’intérieur d’une autre image, **sans aucune utilisation  
d’intelligence artificielle**.  

Grâce à différents **algorithmes de traitement d’image**, `OpenCV` est capable  
de détecter une sous partie dans une image avec un **taux de ressemblance**.  

Voici un exemple simple : une recherche de pièces a été effectuée sur  
l’image de gauche. Le résultat, visible à droite, montre les correspondances  
encadrées en **rouge**.

![Exemple d’utilisation d’OpenCV](https://i.imgur.com/pgQ9LMu.jpeg#center)  
*Image tirée de la documentation officielle d’OpenCV.*
