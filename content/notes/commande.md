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
git push origin <nom de la branche> # permet de push la nouvelle branche
git branch -a # liste de toutes les branches
```

## Droit linux

```
chmod [catégorie]-[droit] fichier_ou_dossier
```

- catégorie :
  - `u` = user (propriétaire)
  - `g` = group (groupe)
  - `o` = others (autres)
  - `a` = all (tous les trois)
- droit :
  - `r` = lecture (read)
  - `w` = écriture (write)
  - `x` = exécution (execute)

```
chmod -R ... # applique la commande de manière récursive
```

## Execution de commande toute l'arborescence

```
find . -type f -exec cmd {} \; # exécute cmd sur tous les fichiers de l'arborescence
```

## Sync dossier local et distant

```
rsync -avz user@remote:dossier_distant dossier_local # sync dossier distant vers local
```

## Docker

```
docker compose down --rmi all --volumes # stop and remove containers along with the related networks, images and volumes
```