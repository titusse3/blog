---
title: "Oracle Quantique"
tags: [Informatique Quantique]
ShowToc: true
math: true
date: "2025-12-16"
---

De nombreux algorithmes quantiques reposent sur la notion d'**oracle quantique**. Cette note a pour but de présenter ce concept est de donner quelques exemples de construction d'oracles.

<!--more-->

# Un Oracle ?

La notion d'oracle, souvent utiliser en cryptographie représente une *boite noire* qui permet de répondre à des questions spécifiques. Par exemple, si j'essaye de deviner le mots de passe d'un compte, j'obtiens l'oracle suivant :

\[
  f: \{0,1\}^n \rightarrow \{0,1\}
\]

Qui a un mots binaire de longueur \(n\) en entrée me renvoie \(1\) si il s'agit bien du mots de passe et \(0\) sinon.

On ne peut en aucun cas connaitre le mots de passe en effectuant quelqu'onque analyse de l'oracle. La seule façon d'obtenir le mots de passe est de faire des essais successifs en appelant l'oracle.

## Oracle Quantique

De nombreux algorithmes quantiques reposent sur cette notion d'oracle quantique. Ces oracles fonctionnent de la même manière que les oracles classiques, à l'exeception qu'au lieu d'être des fonctions, ils sont des opérateurs unitaires.

{{< admonition type="danger" >}}
yrdy
{{< /admonition >}}

# Les deux types d'oracles quantiques

## 

## 

# Calcule d'oracle quantique