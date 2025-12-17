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
  \psi = \frac{1}{\sqrt{2}}(\lvert 110 \rangle + \lvert 100 \rangle)
\]

Peut être vue comme l'ensemble des mots binaires \{110, 100\}. Avec le bit de poids faible à droite. Ce qui nous donne l'ensemble \{6, 4\} en décimal.
{{< /admonition >}}

C'est la que deux types d'oracles quantiques apparaissent. Pour simplifier les choses, on suppose que notre oracle dans le "monde classique" nous renverai la 
chose suivante :

\[
  \begin{equation}
    f(w) = 
      \begin{cases} 
      1 & \text{si } w = 1011 \\
      0 & \text{si } w \in \{0, 1\}^4 \setminus \{1011\}
      \end{cases}
  \end{equation}
\]

## Bit ancillaire

Le premier type d'oracle quantique utilise un **bit ancillaire**. C'est à dire un qubit supplémentaire qui va permettre de stocker le résultat de l'oracle.

De ce faite, la fonction d'onde est alors dans l'espace de *Hilbert* de dimension \(2^{n+1}\) avec \(n\) le nombre de qubits d'entrée. Dans notre exemple, on obtient donc une fonction d'onde \(\psi \in \mathcal{H}^{5}\). Où le dernier qubit est le bit ancillaire.

On obtient alors l'oracle quantique suivant :

\[
  \begin{equation}
    U_f \lvert 0 w \rangle =  
      \begin{cases} 
      \lvert 1 w \rangle & \text{si } w = 1011 \\
      \lvert 0 w \rangle & \text{si } w \in \{0, 1\}^4 \setminus \{1011\}
      \end{cases}
  \end{equation}
\]

## _Phase Kickback_

Le second type d'oracle quantique utilise le concept de **_phase kickback_**. Qui permet de modifier la phase d'une fonction d'onde en fonction de l'état d'un qubit.

Ce que l'on entend par là, c'est modifier le signe de la fonction d'onde. Ce qui donnerai l'oracle quantique suivant :

\[
  \begin{equation}
    U_f \lvert w \rangle =  
      \begin{cases} 
      -\lvert w \rangle & \text{si } w = 1011 \\
      \lvert w \rangle & \text{si } w \in \{0, 1\}^4 \setminus \{1011\}
      \end{cases}
  \end{equation}
\]

Si l'oracle est du type de reconnaissance d'un mot alors il sera de la forme :

\[
  U_f = I - 2 \lvert w \rangle \langle w \rvert
\]

# Calcule d'oracle quantique

On va maintenant voir comment l'on peut construire des circuits quantiques capables de réaliser le fonctionnement d'un oracle quantique.

On rapelle que notre oracle suit la logique de \(f\) qui permet de reconnaitre le mot binaire \(1011\).

## Oracle avec bit ancillaire

On souhaite donc contruire l'opérateur unitaire suivant :

\[
  \begin{equation}
    U_f \lvert 0 w \rangle =  
      \begin{cases} 
      \lvert 1 w \rangle & \text{si } w = 1011 \\
      \lvert 0 w \rangle & \text{si } w \in \{0, 1\}^4 \setminus \{1011\}
      \end{cases}
  \end{equation}
\]



## Oracle avec _phase kickback_

