---
title: "Algorithme sur les automates et langages"
tags: [Théorerie des automates, Théorie des langages]
date: 2025-11-10
ShowToc: true
math: true
---

Présentation des principaux algorithmes utilisés en théorie des langages ainsi qu'en théorie des automates.

<!--more-->

---

## Calcule des résiduels

Soit \(L\) un langage *Rationnel* sur un alphabet \(\Sigma\), donner par une expression rationnelle \(E\) tel que \(L = L(E)\).

{{< admonition >}}
Une expression **rationnelle** est définie par une grammaire de la forme :
- \(E_1 + E_2\)
- \(E_1 \cdot E_2\)
- \(E_1^*\)
- \(\emptyset \; | \; \epsilon \; | \; a\) avec \(a \in \Sigma\)
{{< /admonition >}}

Le résiduel de \(L\) par rapport à un mot \(u \in \Sigma^*\) est défini par :
\[u^{-1}L = \{ v \in \Sigma^* \mid uv \in L \}\]

On peut calculer le résiduel de \(L\) par rapport à \(u\) en utilisant les règles suivantes :
- \(u^{-1}(\emptyset) = \emptyset\), \(\; u^{-1}(\epsilon) = \emptyset\)
- \(u^{-1}(a) = \begin{cases} \epsilon & \text{si } u = a \\ \emptyset & \text{sinon} \end{cases}\)
- \(u^{-1}(E_1 + E_2) = u^{-1}(E_1) + u^{-1}(E_2)\)
- \(u^{-1}(E_1 \cdot E_2) = \begin{cases} u^{-1}(E_1) \cdot E_2 + u^{-1}(E_2) & \text{si } \epsilon \in L(E_1) \\ u^{-1}(E_1) \cdot E_2 & \text{sinon} \end{cases}\)
- \(u^{-1}(E_1^*) = u^{-1}(E_1) \cdot E_1^*\)

{{< admonition >}}
Remarque, on a que : \(u.u^* = u^+\)
{{< /admonition >}}

---

## Algorithme de Standardisation

Soit \(A = (\Sigma, Q, I, F, \delta)\) un automate fini non déterministe. 

L'algorithme de **standardisation** transforme \(A\) en un automate standard 
\[
  A' = (\Sigma, Q \cup \{i\}, \{i\}, F', \delta')
\]
L'algorithme suit les étapes suivantes :
1. Créer un nouvel état initial \(i\),
2. \(F' = \begin{cases} F \text{ si } I \cap F = \emptyset \\ F \cup \{i\} \text{ sinon} \end{cases}\)
3. \(\delta' = \delta \cup \{(i, a, q) | \exists q_i \in I, (q_i, a, q) \in \delta\}\)

### Animation d'exemple
![Gif d'exemple de Standardisation](https://i.imgur.com/n18oPqK.gif)

---

## Algorithme d'émondage

---

## L'algorithme de Glushkov

Soit \(E\) une expression rationnelle sur un alphabet \(\Sigma\). 

L'algorithme de **Glushkov** construit un automate fini non déterministe \[A = (\Sigma, Q, \{0\}, F, \delta) \text{ tel que } L(A) = L(E)\]

| Expression \(E\) | \(Null(E)\) | \(First(E)\) | \(Last(E)\) |
|---|:---:|:---:|:---:|
| \(\emptyset\) | \(\varnothing\) | \(\varnothing\) | \(\varnothing\) |
| \(\epsilon\) | \(\{\epsilon\}\) | \(\varnothing\) | \(\varnothing\) |
| \(a \in \Sigma\) | \(\varnothing\) | \(\{a\}\) | \(\{a\}\) |
| \(E_1 + E_2\) | \(Null(E_1) \cup Null(E_2)\) | \(First(E_1) \cup First(E_2)\) | \(Last(E_1) \cup Last(E_2)\) |
| \(E_1 \cdot E_2\) | \(Null(E_1) \cap Null(E_2)\) | \(First(E_1) \cup Null(F) \cdot First(G)\) | \(Last(E_2) \cup Null(E_2) \cdot Last(E_1)\) |
| \(E^*\) | \(\{\epsilon\}\) | \(First(E)\) | \(Last(E)\) |

Pour fonction \(Follow(E)\) :
- \(Follow(\emptyset, x) = \emptyset\)
- \(Follow(\epsilon, x) = \emptyset\)
- \(Follow(a, x) = \emptyset\)
- \(Follow(E_1 + E_2, x) = Follow(E_1, x) \cup Follow(E_2, x)\)
- \(Follow(E_1 \cdot E_2, x) = \begin{cases} Follow(E_1, x) \cup First(E_2) & \text{si } x \in Last(E_1) \\ Follow(E_1, x) & \text{sinon} \end{cases} \cup \begin{cases} Follow(E_2, x) & \text{si } x \notin First(E_2) \\ \emptyset & \text{sinon} \end{cases}\)
- \(Follow(E^*, x) = \begin{cases} Follow(E, x) \cup First(E) & \text{si } x \in Last(E) \\ Follow(E, x) & \text{sinon} \end{cases}\)

\(\delta\) est défini par :
\[\delta = \{(p, a, q) | p \in Q, q \in Follow(E, p) \text{ et } p \text{ étiqueté par } a\}\]
L'ensemble des états finaux \(F\) est défini par :
\[F = \begin{cases} Last(E) \cup \{\epsilon\} & \text{si } \epsilon \in L(E) \\ Last(E) & \text{sinon} \end{cases}\]

---

## Algorithme de déterminisation

Soit \(A = (\Sigma, Q, I, F, \delta)\) un automate fini non déterministe.
L'algorithme de **déterminisation** transforme \(A\) en un automate fini déterministe
\[A' = (\Sigma, Q', \{I\}, F', \delta')\]

L'algorithme suit les étapes suivantes :
1. \(Q' = \mathcal{P}(Q)\) (l'ensemble des parties de \(Q\)),
2. \(F' = \{S \subseteq Q \mid S \cap F \neq \emptyset\}\),
3. Pour chaque \(S \in Q'\) et chaque \(a \in \Sigma\), définir \(\delta'(S, a) = \bigcup_{q \in S} \delta(q, a)\).

La méthode d'application est la suivante :

1. Regroupement des états initiaux en un seul état initial.
2. On part de cette état initial et on calcule les transitions pour chaque symbole de l'alphabet.
3. On répète l'opération pour chaque nouvel état créé jusqu'à ce qu'aucun nouvel état ne puisse être créé.

![Gif d'exemple de Déterminisation](https://i.imgur.com/jJN7EqJ.gif)

---

## Algorithme de minimisation
