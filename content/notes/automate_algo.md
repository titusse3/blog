---
title: "Algorithme sur les automates et langages"
tags: [Théorerie des automates, Théorie des langages]
date: 2025-11-10
ShowToc: true
math: true
---

# Calcule des résiduels

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

# Algorithmes de Glushkov


- Determinisation
- Minimisaton
- Standardisation
- émondage