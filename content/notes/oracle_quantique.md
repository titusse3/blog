---
title: "Oracle Quantique"
tags: [Informatique Quantique]
ShowToc: true
math: true
date: "2025-12-16"
---

De nombreux algorithmes quantiques reposent sur la notion **d’oracle quantique**. Cette note a pour but de présenter ce concept et de donner quelques exemples de construction d’oracles.

<!--more-->

# Un Oracle ?

La notion d'oracle, souvent utilisée en **cryptographie** représente une *boite noire* qui permet de répondre à des questions spécifiques. 

Cette boite noire est souvent représentée par une fonction \(f\) qui permet de tester l'appartenance d'un élément à un ensemble.

Par exemple, si j'essaye de deviner le mot de passe d'un compte de \(n\) bits, j'obtiens l'oracle suivant :

\[
  f: \{0,1\}^n \rightarrow \{0,1\}
\]

Qui a un mot en entrée me renvoie \(1\) si il s'agit bien du mot de passe et \(0\) sinon.

En **cryptographie**, un oracle constitue une construction théorique qui permet de prouver des propriétés de sécurité. C'est pour cela que l'on ne peut rien déduire de l'oracle lui-même. Pour obtenir le mot de passe, pour notre exemple, il faudra donc invoquer l'oracle un certain nombre de fois. A l'aide de ces appels, on pourra alors espérer deviner le mot de passe.

### Exemple d'oracle

Le principe d'oracle est utilisé dans un jeu assez connu :
[Akinator](https://fr.akinator.com/). 

Pour ceux qui ne connaissent pas ce site, il s'agit d'un jeu où l'on pense à un personnage et génie du site essaie de deviner de quel personnage il s'agit en posant une série de questions. 

<img src="https://i.imgur.com/6UZMmIL.gif#center" />

Le génie *"Akinator"* nous pose donc des questions que nous pouvons répondre que par oui ou par non. Il est évident que *"Akinator"* ne peut pas essayer de deviner le personnage auquel on pense à l'aide d'une autre méthode que de poser des questions. C'est seulement par le biais des réponses qu'on lui donne qu'il peut espérer deviner le personnage.

En effet, le génie *"Akinator"* **utilise un oracle** qui lui permet de tester l'appartenance du personnage auquel on pense à un ensemble de personnages. La personne qui répond à ces questions agit donc comme un oracle pour ce petit génie.

## Oracle Quantique

De nombreux **algorithmes quantiques** reposent sur cette notion d'oracle quantique. Ces oracles, ne constitue pas des constructions théorique mais bien des objets qui serait possible de constuire sur un **ordinateur quantique**. 

Ces oracles fonctionnent de la même manière que les oracles classiques, à l'exeception qu'au lieu d'être des fonctions, ils sont ce que l'on appelle des **opérateurs unitaires**.

En effet, en informatique quantique classique, on ne peut réaliser que deux types d'opérations sur les fonctions d'ondes quantiques :
- Les **opérations unitaires** (portes quantiques) qui sont réversibles.
- Les **projecteurs de mesure** qui ne sont pas réversibles.

### Opérateurs unitaires vs Projecteurs de mesure

Les **opérateurs unitaires**, représentent simplement des transformations réversibles sur les fonctions d’onde quantiques (ils représentent d’ailleurs, d’un point de vue mathématique, des opérateurs de changement de base).

Le points à retenir pour notre sujet est qu'un **opérateur unitaire** est réversible. C'est à dire que l'on peut toujours retrouver l'état initial de la fonction d'onde après application de l'opérateur.

A l'inverse, les **projecteurs de mesure** ne sont pas réversibles. En effet, la **mesure**, action consistant à extraire une information classique d'une fonction d'onde quantique, modifie irréversiblement l'état de la fonction d'onde. On ne peut donc pas retrouver l'état initial de la fonction d'onde après une mesure.

Dans ce contexte, les oracles quantiques sont donc des **opérateurs unitaires** qui permettent de tester l'appartenance d'un élément à un ensemble, tout en respectant la réversibilité imposée par la mécanique quantique.

### Représentation d'un oracle quantique

De cette représentation découle un problème. En effet, les oracles classique, comme vue précédament réponde par oui ou par non à une question (\(0\) ou \(1\)). Cependant, un opérateur unitaire doit conserver la dimension de l'espace dans lequel il agit.

{{< admonition >}}
Dans cette note, nous prenons la convention de représenter les *qbits* avec le bit de poids faible à droite. Par exemple, la fonction d'onde suivante :
\[
  \psi = \frac{1}{\sqrt{2}}(\lvert 110 \rangle + \lvert 100 \rangle)
\]

Peut être vue comme l'ensemble des mots binaires \{110, 100\}. Avec le bit de poids faible à droite. Ce qui nous donne l'ensemble \{6, 4\} en décimal.
{{< /admonition >}}

## Bit ancillaire

Le premier type d'oracle quantique utilise un **bit ancillaire**. C'est à dire un qubit supplémentaire qui va permettre de stocker le résultat de l'oracle.

Dans ce cas, notre fonction d'onde d'entrée sera composée de deux parties :
\[
  \lvert b w \rangle
\]
Où \(b\) est le bit ancillaire et \(w\) le mot binaire que l'on souhaite tester.

De cette definition, un oracle quantique \(U_f\) agira de la manière suivante sur la fonction d'onde d'entrée :

\[
  \begin{equation}
    U_f \lvert 0 w \rangle =  
      \begin{cases} 
      \lvert 1 w \rangle & \text{si w \textbf{vérifie} } f \\
      \lvert 0 w \rangle & \text{sinon }
      \end{cases}
  \end{equation}
\]

## _Phase Kickback_

Le second type d'oracle quantique utilise le concept de **_phase kickback_**. Qui permet de modifier la phase d'une fonction d'onde en fonction de l'état d'un qubit.

Ce que l'on entend par là, c'est modifier le signe de la fonction d'onde. Ce qui donnerai l'action suivante pour un oracle quantique \(U_f\) :

\[
  \begin{equation}
    U_f \lvert w \rangle =  
      \begin{cases} 
      -\lvert w \rangle & \text{si w \textbf{vérifie} } f \\
      \lvert w \rangle & \text{sinon}
      \end{cases}
  \end{equation}
\]

{{< admonition type="note" >}}
Les deux types d'**oracles quantiques** présentés sont équivalents. En effet, il est même possible de construire un oracle avec bit ancillaire à partir d'un oracle avec _phase kickback_ et inversement.

Le choix d'utiliser l'un ou l'autre dépend souvent du contexte de l'algorithme quantique utilisé.
{{< /admonition >}}

# Calcule d'oracle quantique

On va maintenant voir comment construire des circuits quantiques capables de réaliser le fonctionnement d'un oracle quantique.

Nous allons voir comment construire les deux types d'oracles pour le problème suivant :
> Soit un mot binaire de 4 bits \(w \in \{0, 1\}^4\). Construire un oracle quantique qui reconnaît le mot \(1011\).

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

Si le mot que l'on recherchait était \(1111\), cela serait assez simple. En effet, il suffirait de verifier que chaque qbit est à l'état \(\lvert 1 \rangle\) (sans prendre en compte le bit aucillaire qui serait lui bien évidement à \(\lvert 0 \rangle\)).

Si tous les qubits sont à l'état \(\lvert 1 \rangle\), on applique une porte \(X\) sur le dernier qubit (le bit ancillaire) pour le mettre à l'état \(\lvert 1 \rangle\).

Or l'opération ci-dessus est simplement l'application de l'opération 

\[
  X-c-c-c-c
\]

Qui controle les quatre premiers qubits pour appliquer une porte \(X\) sur le dernier qubit (Ce qui revient simplement a vérifier que les quatre premiers qubits sont à l'état \(\lvert 1 \rangle\) pour appliquer \(X\)).

On peut alors vérifier que si l'oracle rechercher le mots \(1111\), alors l'opérateur \(U_f = X-c-c-c-c\) répond bien à la définition de l'oracle.

<details>
  <summary>Calcule de vérification</summary>

  Pour que \(X-c-c-c-c\) vérifie la définition de l'oracle, il faut que :
  - Pour tous qbits différent de \(1111\), l'état du bit ancillaire reste à \(\lvert 0 \rangle\).
  - Pour le qbit \(1111\), l'état du bit ancillaire passe à \(\lvert 1 \rangle\).

  On vérifie donc les deux conditions :

  \[
    X-c-c-c-c = X \otimes | 1111 \rangle \langle 1111 |  +  I \otimes ( I^{\otimes 4} - | 1111 \rangle \langle 1111 | )
  \]

  - Pour tous qbits différent de \(1111\) :
  \[
    \begin{aligned}
      U_f | 0 w \rangle &= \left( X \otimes | 1111 \rangle \langle 1111 |  +  I \otimes ( I^{\otimes 4} - | 1111 \rangle \langle 1111 | ) \right) | 0 w \rangle \\
      &= I | 0 w \rangle \\
      &= | 0 w \rangle
    \end{aligned}
  \]

  - Pour le qbit \(1111\) :
  \[
    \begin{aligned}
      U_f | 0 1111 \rangle &= \left( X \otimes | 1111 \rangle \langle 1111 |  +  I \otimes ( I^{\otimes 4} - | 1111 \rangle \langle 1111 | ) \right) | 0 1111 \rangle \\
      &= X | 0 \rangle \otimes | 1111 \rangle \\
      &= | 1 1111 \rangle
    \end{aligned}
  \]

</details>


Cependant, notre oracle doit reconnaitre le mot \(1011\) et non \(1111\). Pour cela, on va utiliser des portes \(X\) pour inverser les qubits qui doivent être à \(\lvert 0 \rangle\) et des identités dans le cas où les bits sont à 
\(\lvert 1 \rangle\). Sans oublier de remettre les qubits à leur état initial après l'application de la porte contrôlée.

Ce qui nous donne l'opérateur suivante pour notre oracle :

\[
  U_f = (I \otimes I \otimes X \otimes I \otimes I) X-c-c-c-c (I \otimes I \otimes X \otimes I \otimes I)
\]

## Oracle avec _phase kickback_

On souhaite donc contruire l'opérateur unitaire suivant :

\[
  \begin{equation}
    U_f \lvert w \rangle =  
      \begin{cases} 
      -\lvert w \rangle & \text{si } w = 1011 \\
      \lvert w \rangle & \text{si } w \in \{0, 1\}^4 \setminus \{1011\}
      \end{cases}
  \end{equation}
\]

Pour faire cela, on va essayer de procéder de la même manière que pour l'oracle avec bit ancillaire. On va donc essayer de construire une porte contrôlée qui applique une porte \(Z\) (qui modifie la phase) si les qubits sont à l'état \(1111\).

Pour rapelle, la porte \(Z\) est définie de la manière suivante :
\[
  Z = | 0 \rangle \langle 0 | - | 1 \rangle \langle 1 |
\]

On peut alors vérifier que si l'oracle rechercher le mots \(1111\), alors l'opérateur \(U_f = Z-c-c-c-c\) répond bien à la définition de l'oracle.

Et de la même manière que pour l'oracle avec bit ancillaire, on va utiliser des portes \(X\) pour inverser les qubits qui doivent être à \(\lvert 0 \rangle\) et des identités dans le cas où les bits sont à 
\(\lvert 1 \rangle\). Sans oublier de remettre les qubits à leur état initial après l'application de la porte contrôlée.

Ce qui nous donne l'opérateur suivante pour notre oracle :
\[
  U_f = (I \otimes X \otimes I \otimes I) Z-c-c-c (I \otimes X \otimes I \otimes I)
\]

# Conclusion

Nous avons donc vue deux types d'oracles quantiques et comment les construire.
Le choix entre les deux types d'oracles dépend souvent du contexte de l'algorithme quantique utilisé. Certains algorithmes peuvent bénéficier de l'utilisation d'un bit ancillaire pour stocker des informations supplémentaires, tandis que d'autres peuvent tirer parti du _phase kickback_ pour manipuler les phases des états quantiques de manière plus efficace.

Typiquement, le célèbre algorithme de Grover utilise un oracle basé sur le _phase kickback_ pour marquer les états cibles en modifiant leur phase, ce qui permet d'amplifier la probabilité de mesurer ces états lors de la phase de diffusion de l'algorithme.