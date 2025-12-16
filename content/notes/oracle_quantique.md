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

En en effet, en informatique quantique classique, il n'existe que deux type de "fonction" applicable à des qubits :
- Les opérations unitaires (portes quantiques) qui sont réversibles.
- Les projecteurs de mesure qui ne sont pas réversibles.

Or lorsqu'on l'on utilise un oracle de manière générale, on souhaite pouvoir rester dans le cadre de notre calcule. Chose impossible si l'on utilise un projecteur qui projette l'état du système. C'est pourquoi les oracles quantiques sont toujours des opérateurs unitaires.

{{< admonition type="info" >}}
Un opérateur quantique est dit **unitaire** si et seulement si :
\[
  U U^{\dagger} = I
\]
Avec \(I\) l'identité dans l'espace considéré.
{{< /admonition >}}

De cette représentation découle un problème. En effet, les oracles retourne souvent une valeur binaire (0 ou 1) en fonction de l'appartenance à la propriété tester du paramettre. 

Cependant, avec notre représentation d'oracle, par une fonction unitaire, il est impossible de retourner une valeur (0 ou 1). Car par définition une fontion unitaire doit conserver la dimension de l'espace.

{{< admonition >}}
Une fonction d'onde quantique, peut être vue comme un "ensemble" de mots binaires. Par exemple, si on prend la fonction d'onde suivante :
\[
  \phi = \frac{1}{\sqrt{2}}(\lvert 110 \rangle + \lvert 100 \rangle)
\]

Peut être vue comme l'ensemble des mots binaires \{110, 100\}. Avec le bit de poids faible à droite. Ce qui nous donne l'ensemble \{6, 4\} en décimal.
{{< /admonition >}}

C'est la que deux types d'oracles quantiques apparaissent.

## 

## 

# Calcule d'oracle quantique