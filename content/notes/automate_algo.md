---
title: "Algorithme sur les automates et langages"
tags: [Théorerie des automates, Théorie des langages]
date: 2025-11-10
ShowToc: true
math: true
---

Présentation des principaux algorithmes utilisés en théorie des langages ainsi qu'en théorie des automates.

<!--more-->

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

## L'algorithme de Glushkov

## Algorithme de déterminisation

## Algorithme de minimisation
