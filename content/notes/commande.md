---
title: "Memo de commande linux"
tags: [Linux, commande]
ShowToc: true
---

Mémo de commande très pratique.

<!--more-->

## Changement de la version de java utiliser

```
sudo update-alternatives --config java 
```

## Commande Obelisk

```
ob init # créer un projet
ob run # lance le projet
ob hoogle # lance une doc hoogle du projet
```

## Réseaux

```
ss -tnlp # liste tous les ports écoutés par la machine
ip addr # affiche les interfaces réseau
```

## GPG

```
gpg --list-key # liste des clés
```

## Git

```
git checkout -b <nom de la branche> # premet de créer et de changer de branche
git push origin [nom de la branche] # permet de push la nouvelle branche
git branch -a # liste de toutes les branches
```