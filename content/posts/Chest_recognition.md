---
title: "Extraction d'information sur image (Chest-Reco)"
date: "2025-10-27"
tags: [Python, Automatisation]
ShowToc: true
---

Le jeu *Garry's mod*, est une sorte de platforme où l'on peut retrouver de nombreux mini-jeu. Cette article traite de la mise en place d'une extraction des ressources présentes dans d'image d'un coffre de ce jeu.
Cet article expliquera en détail la mise en place de ce projet Python, disponible sur GitHub : [dépôt GitHub](https://github.com/titusse3/chest-reco).

# Description du problème

Dans le mini-jeu *Naruto RP*, il existe des coffres, dans lequel on peut stocker des ressources. Ces ressources qui permettre de construire d'autre éléments.
Il vient très vite le problème de savoir combien de ces éléments je peux créer avec mon coffre actuelle. Vue qu'aucune **API** n'est disponible, j'ai donc décider de mettre en place une petite application d'extraction d'information de capture d'écran pris des coffres.

Pour exemple, voici à quoi ressemble le contenue total d'un telle coffre :

![Exemple de contenu du coffre](https://i.imgur.com/AWLVAeL.gif#center)

## Fragementation du problème

J'ai donc choisie de fragmenter le problème de la façon suivante:
- Extraction de la partie de l'image représentant un item,
- Récupération du nombre de cette item,
- Mise en forme des résultats

# Objectif

L'objectif tous d'abord est de récupérer pour chaqu'une des ressources du coffres leur nombres. Je veux bien évidement que je n'aille besoin d'aucune 
intéraction humaine, si ce n'est de donner le chemin du dossier ou ce trouve 
l'ensemble des captures d'écran du coffre.

Les contraites pour le projet sont les suivantes:
- Une bonne architectures de projet python,
- Un programme ne n'éssécitant pas un grand nombre de ressources,
- La possibilité de poursuivre le projet pour y ajouter des fonctionnalités.

# Architecture du projet python

Après quelque recherche sur les divers architectures recommander pour un projet python, j'ai choisie celui qui me convenait le mieux. Pour cela, j'ai opter pour l'architecture suivante:

```
.
├── project/
│   ├── modules1/
│   ├── ...
│   ├── modulesN/
│   ├── ressources/
│   └── main.py
└── tests/
    ├── system_tests/
    ├── integration_tests/
    └── unit_tests/
```

On sépare bien la partie des `tests` de celle du `projet`. Pour la partie test,
le module `Pytest` est utiliser.