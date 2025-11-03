---
title: Mesure Quantique
date: "2025-03-01"
categories: [Informatique Quantique, mesure]
math: true
---

<!--more-->

La **mesure** est l'opération qui permet d'obtenir une information d'un *qubit* 
sur un registre classique. C'est donc l'une des opérations les plus importantes 
en informatique quantique.

Tout d'abord, il faut savoir qu'une mesure s'effectue à l'aide d'un opérateur, 
que nous noterons \(\mathcal{O}\). Pour être valide, cet opérateur doit être 
**hermitien** :

$$
\text{Si } \mathcal{O}^{\dagger} = \mathcal{O} \text{ alors } \mathcal{O} 
\text{ est }\textbf{hermitien}
$$
Une fois que nous avons établi cette propriété, l'opérateur \(\mathcal{O}\) est
qualifié d'**observable**. Pour effectuer une mesure, il convient alors de 
suivre les étapes suivantes :

1. **Déterminer les valeurs et vecteurs propres de l'observable.**<br>
Pour rappels si :
$$
\mathcal{O}\ket{\phi} = \lambda\ket{\phi}\\
$$
Alors :
$$
\begin{cases}
  \lambda \;\;\;\textbf{ valeur propre}, \\
  \ket{\phi} \textbf{ vecteur propre}.
\end{cases}
$$
On va chercher pour chaque **valeur propre** \(\lambda\) à créer un *espace 
vectoriel* \(E_\lambda\) aillant pour base les **vecteurs propre** associer à 
cette **valeur propre**.
$$
E_\lambda = Vect\{\ket{\phi_0}, \cdots, \ket{\phi_n}\} 
$$
où les \(\ket{\phi_i}\) sont les **vecteurs propres** correspondant à la 
**valeur propre** \(\lambda\).
2. **Définir les projecteurs associés.**<br>
On définit le projecteur \(P_\lambda\) par :
$$
P_\lambda = 
\sum_{\ket{\phi_i} \in \mathcal{B}(E_\lambda)} \ket{\phi_i}\bra{\phi_i}
$$
où \(\mathcal{B}(E_\lambda)\) représente la base de l'espace \(E_\lambda\).
Les **projecteurs** ainsi définis correspondent aux opérateurs que l'on applique 
sur le *qubit* à mesurer.
{{< admonition >}}
Les **projecteurs** \(P\) respecte la propriété \(P^2 = P\).
{{< /admonition >}}
3. **Opération de mesure.**<br>
Il est maintenant temps d'appliquer notre mesure sur une fonction d'onde que l'on 
appellera \(\ket{\psi}\). Avant de procéder à cette opération, il est essentiel 
de bien comprendre son principe. <br>
Nous partons d'une fonction d'onde \(\ket{\psi}\), qui est un vecteur dans un 
espace \(A\). Appliquer une mesure sur \(\ket{\psi}\) revient à projeter ce 
vecteur dans un nouvel espace.<br> 
L'espace vers lequel \(\ket{\psi}\) sera projetée est l'un des \(E_\lambda\), 
avec une probabilité déterminée.
Pour réaliser ce changement de base, il suffit d'utiliser les **projecteurs** 
que nous avons calculés au préalable. En résumé, l'opération peut être illustrée 
par l'arbre suivant :
![Arbre probabiliste de la mesure](https://i.imgur.com/lU6a2I1.png)

Cependant, appliquer un projecteur \(P_{\lambda_i}\) ne conserve pas la norme 
du vecteur. Cela signifie que, après l'application du projecteur, le vecteur ne 
restera plus sur la sphère de *Bloch*, ce qui empêche une nouvelle mesure de 
notre fonction d'onde \(P_{\lambda_i}\ket{\psi}\). C'est pourquoi l'arbre de 
mesure doit être modifié, comme illustré ci-dessous :
![Arbre complet de la mesure](https://i.imgur.com/CU3VJNR.png)

Grâce à cette multiplication par l'inverse de la probabilité, notée 
\(\mathbb{P}(E_{\lambda_i})\) d'appliquer notre **projecteur**, la norme reste 
la même.<br>
Cette probabilité est donnée par la formule suivante :

$$
\mathbb{P}(E_{\lambda_i}) = 
\dfrac{\bra{\psi} P_{\lambda_i} \ket{\psi}}{\bra{\psi} \ket{\psi}}
$$

{{< admonition >}}
Dans le cas où \(\ket{\psi}\) est **normalisé**, \(\bra{\psi} \ket{\psi} = 1\).
{{< /admonition >}}

En suivant ces étapes, vous pourrez réaliser la mesure. Le seul détail que j'ai 
omis est que, après l'application du **projecteur**, une information est 
transmise dans un registre classique. Cette information dépend du \(\lambda_i\) 
correspondant. Par exemple, il est courant de considérer que pour 
\(\lambda = 1\), le résultat enregistré dans le registre classique est 0, et 
pour \(\lambda = -1\), il est 1. Je ne vais pas développer davantage sur ce 
sujet, n'étant pas suffisamment familier avec les propriétés physiques 
permettant cette interprétation matérielle. 

---

### Optimisation des calculs

Il est clair que le calcul le plus long de notre mesure sera 
\(\mathbb{P}(E_{\lambda_i})\). En reprenant notre formule :

$$
\mathbb{P}(E_{\lambda_i}) = 
\dfrac{\bra{\psi} P_{\lambda_i} \ket{\psi}}{\bra{\psi} \ket{\psi}}
$$

Nous savons déjà que \(\bra{\psi}\ket{\psi}\) correspond au module au carré des 
coefficients de notre fonction d'onde \(\ket{\psi}\).<br>
Concernant le calcul de \(P_{\lambda_i}\ket{\psi}\), nous avons :

$$
P_{\lambda_i} \ket{\psi} = \sum_{\ket{\phi_i} \in \mathcal{B}(E_\lambda)} 
\ket{\phi_i} \bra{\phi_i} \ket{\psi}
$$

On constate ainsi que si \(\ket{\psi}\) appartient déjà à la base \(\mathcal{B}
(E_\lambda)\), il suffit de lire les coefficients associés. Cela permet de 
grandement accélérer le calcul. Par conséquent, il peut être intéressant 
d'envisager de changer la base de \(\ket{\psi}\) pour celle de notre **espace 
propre** \(\mathcal{B}(E_\lambda)\).