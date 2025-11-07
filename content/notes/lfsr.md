---
title: LFSR pratique
date: "2025-04-07"
categories: [Calcule Formelle, Série, Cryptographie]
math: true
---

Cette note offre une brève introduction aux *LFSR*. Je me concentrerai sur les 
éléments essentiels pour en saisir le principe, sans entrer dans l'ensemble des 
détails théoriques.

<!--more-->

Pour commencer, les *LFSR* sont des suites linéaires récurrentes employées en 
cryptographie afin de générer des nombres de façon pseudo-aléatoire. La manière 
la plus intuitive de les illustrer consiste à utiliser une analogie avec une boîte 
à œufs, comme le montre l'ilustration ci-dessous.

![Image d'un *LFSR*](https://i.imgur.com/FMELxUF.png)

Le principe est assez simple : les valeurs visibles correspondent à l'état 
d'initialisation. Pour obtenir la valeur suivante, il suffit de reproduire 
exactement la méthode illustrée dans l'animation ci-dessous.

![Animation *LFSR*](https://i.imgur.com/zxNV38p.gif)

---

Dans cet article, je m'intéresserai exclusivement aux *LFSR* opérant dans 
l'ensemble \(\mathbb{F}[X]_2^n\), c'est-à-dire dans l'espace des nombres 
binaires (0 et 1). De plus, l'unique opération utilisée est le *xor* (souvent 
noté \(\oplus\)), dont la table de vérité est la suivante :

| A | B | A \(\oplus\) B |
|---|---|-------|
| 0 | 0 | 0     |
| 0 | 1 | 1     |
| 1 | 0 | 1     |
| 1 | 1 | 0     |

Puisque je me limite à cet ensemble, j'utiliserai le symbole + à la place de 
\(\oplus\), tout en continuant à désigner l'opération comme étant le *xor*.

## Réprésentation sous forme de récurence linéaire

Dans la suite de cet article, j'appellerai \(s_n\) la suite associée au *LFSR* 
illustré dans l'image. Il faut comprendre que les valeurs contenues dans la 
boîte correspondent aux termes initiaux de la suite. Ce n'est pas compliqué : il 
suffit de respecter l'ordre des termes, qui sont indexés à partir de 0, en 
partant de la droite vers la gauche. Ainsi, pour notre *LFSR*, les termes 
initiaux sont les suivants :

\[
\begin{cases}
s_0 = 1 \\
s_1 = 0 \\
s_2 = 0 \\
s_3 = 1 \\
s_4 = 1 \\
\end{cases}
\]

Une fois ces termes initiaux trouvé, il nous suffis de trouver les coefficients 
de l'expresion réccurente de notre suite \(s_n\). Tout d'abords, il faut savoir
que l'expression sera de la forme :

\[
s_n = c_1 s_{n - 1} + c_2 s_{n - 2} + c_3 s_{n - 3} + c_4 s_{n - 4} + c_5 s_{n - 5} 
\]

Les termes \(s_{n-i}\) proviennent du fait que notre boîte à œufs contient cinq 
valeurs. Pour déterminer les coefficients \(c_i\), il suffit de repérer les 
indices des symboles \(\oplus\) dans notre schéma, en les parcourant cette fois 
de gauche à droite (contrairement à l'indexation des \(s_i\)). Comme le montre 
le dessin, on obtient ainsi :

![Image montrant les indices des C_i](https://i.imgur.com/LMS4xUd.png)

\[
\begin{aligned}
s_n &= 0 \times s_{n-1} + 1 \times s_{n-2} + 0 \times s_{n-3} + 
    0 \times s_{n-4} + 1 \times s_{n-5} \\
    &= s_{n-2} + s_{n-5}.
\end{aligned}
\]

Cela signifie que pour calculer le terme suivant, on additionne (en appliquant 
l'opération xor) le quatrième et le premier terme.

## Périodicité

Maintenant que nous avons saisi son fonctionnement, intéressons-nous à 
quelques-unes de ses propriétés. Pour reprendre l'exemple du *LFSR* présenté 
dans l'image, considérons que le nombre généré au rang \(i\) correspond à 
l'ensemble des valeurs affichées dans la boîte à œufs à ce moment. Ainsi, le 
premier nombre noté (au rang 0) est \([1, 0, 0, 1, 1]\), le deuxième (au rang
1) \([0, 0, 1, 1, 0]\) (j'ai choisi de le représenter selon l'ordre des 
\(s_i\)), et ainsi de suite. On notera cette suite de valeur \(e_i\)

On constate que cette suite évolue dans \(\mathbb{F}_2^{5}\). Par ailleurs, 
puisque la suite \(s_n\) est infinie et que \(\mathbb{F}_2^{5}\) est un ensemble 
fini (il n'existe qu'un nombre limité de mots binaires sur 5 bits), il est 
inévitable qu'à un certain rang, pour certains indices \(n\) et \(n'\), on ait :

$$
  s_n = s_{n'}
$$

Notre objectif étant de générer des nombres pseudo-aléatoires, il est important 
de connaître la période de cette suite pour déterminer si le *LFSR* est 
suffisamment performant (une période très longue étant souhaitable). Pour cela, 
nous utiliserons l'algorithme de **Floyd**, plus connu sous le nom de 
l'algorithme du *lièvre et de la tortue*.

### Algorithme de **Floyd**

Cet algorithme se déroule en deux étapes :

1. Tout d'abord, on cherche un rang \(i > 0\) tel que \(e_i = e_{2i}\), où 
\(e_i\) représente le nombre généré par le *LFSR* au rang \(i\). Pour ce faire, 
il suffit de faire progresser le *LFSR* et de comparer les valeurs obtenues. 
Une fois cette égalité identifiée, on enregistre ce rang sous le nom \(n\).

2. Ensuite, on répète la procédure en recherchant une égalité similaire pour 
\(e_{i+1} = e_{2(i+1)}\) avec \(i > n\). Dès que cette condition est remplie, 
on note le rang \(i + 1\) sous le nom \(n_1\).

La période de la suite, notée \(\lambda\), est alors donnée par  
\[
\lambda = n_1 - n.
\]

{{< admonition >}}
On ne prend pas en compte \(e_0\), le nombre généré par les valeurs initiales 
du *LFSR* avant toute opération.
{{< /admonition >}}

Essayer de trouver la période associée au *LFSR* défini par la suite \(s_n\) :

\[
\begin{cases}
s_0 = 1 \\
s_1 = 0 \\
s_2 = 0 \\
s_3 = 1 \\
s_n = s_{n-2} + s_{n-4}\\
\end{cases}
\]

<details>
  <summary>Correction</summary>

  Comme évoqué ci-dessus, il suffit de calculer les nombres générés par le 
  *LFSR* jusqu'à obtenir les égalités \(e_i = e_{2i}\) et 
  \(e_{i + 1} = e_{2(i + 1)}\).

  Pour ce faire :
  
  ![Réponse](https://i.imgur.com/3AbtadJ.png)

  Dans cette image, les nombres sont écrits sous forme de vecteurs, avec 
  \(s_0\) représentant le bit le plus haut.

  On trouve ainsi que \(n = 6\) et \(n_1 = 12\), d'où la période du *LFSR* est 
  \(\lambda = 6\).

  Un bon moyen de s'exercer est d'utiliser le site [dcode](https://www.dcode.fr/registre-decalage-retroaction-lineaire), 
  qui permet de déterminer la période d'un LFSR que vous aurez vous-même conçu. 
  Veillez toutefois à bien prendre en compte l'indexation des coefficients, qui 
  diffère de celle utilisée dans cette note.

</details>

---

Nous avons ainsi calculé la période. Cependant, certaines suites ne commencent 
pas directement par leur cycle périodique complet ; il peut exister un chemin 
préliminaire avant d'entrer dans le cycle. On appelle cette phase la *queue* de 
la suite. Pour calculer la longueur de la *queue*, notée \(\mu\), il suffit de 
réappliquer la première étape de l'algorithme de Floyd, mais cette fois-ci en 
recherchant \(e_i = e_{i + \lambda}\), en commençant à \(i = 0\) (comme 
précédemment).

Essayer maintenant de calculer \(\mu\) de la suite donner précédament.

<details>
  <summary>Correction</summary>

  Il suffit de reprendre le calcule des \(e_i\) précédent, on remarque alors 
  que \(e_0 = e_{0 + 6}\) et que donc \(\mu = 0\).
</details>

---

### Période maximale

Une propriété essentielle et relativement facile à comprendre est la valeur de 
la période maximale d'un *LFSR*. Si notre *LFSR* prend des valeurs dans 
\(\mathbb{F}_2^n\), cela signifie que sa période couvre l'ensemble de 
\(\mathbb{F}_2^n\) (à l'exception du vecteur nul, qui est rejeté puisqu'il 
correspond à un élément absorbant).

Ainsi, la période maximale est :
\[
  |\mathbb{F}_2^n| - 1 = 2^n - 1.
\]

## Représentation sous forme matricielle

Tout comme on peut représenter notre *LFSR* sous forme de suite linéaire, il 
est également possible de l'exprimer sous forme de matrice.

Pour entrer dans les détails, il convient de distinguer deux matrices. La 
première, notée \(S\), regroupe les \(s_i\) :

\[
S = \begin{pmatrix}
s_0 \\
s_1 \\
s_2 \\
\vdots \\
s_{l-1}
\end{pmatrix}
\]

où \(l\) correspond au nombre de valeurs présentes dans notre boîte à œufs.

La deuxième matrice, notée \(M\), représente la logique de rétroaction de notre 
*LFSR*. Il s'agit d'une matrice carrée de dimension \(l \times l\) de la forme 
suivante :

\[
M = \begin{pmatrix}
0      & 1      & 0      & \cdots & 0      \\
0      & 0      & 1      & \cdots & 0      \\
\vdots & \vdots & \ddots & \ddots & \vdots \\
0      & 0      & \cdots & 0      & 1      \\
c_l    & c_{l - 1}    & \cdots & c_2 & c_1
\end{pmatrix}
\]

Pour se convaincre de cette écriture, calculons \(M \times S\) :

\[
  M \times S = \begin{pmatrix}
s_1 \\
s_2 \\
\vdots \\
s_{l-2}\\
s_{l-1}\\
c_ls_0 + c_{l-1}s_1 + \cdots + c_1s_{l - 1}
\end{pmatrix}
\]

On retrouve ainsi le décalage qui fait disparaître \(s_0\) et le calcul de 
\(s_l\) s'effectue par une combinaison linéaire des \(c_i\).

{{< admonition >}}
On peut remarquer que, pour calculer les \(e_i\) utilisés pour déterminer la 
période, il suffit de poser :
\[
e_0 = S, \; e_n = M\times e_{n - 1}.
\]
{{< /admonition >}}

### Périodicité

On dit qu'une suite est **périodique** si et seulement si \(\mu = 0\). Dans le 
cas d'un *LFSR*, cela équivaut à dire que \(c_l \neq 0\), où \(l\) représente 
le nombre de valeurs de notre boîte à œufs.

{{< admonition >}}
Cette proposition se démontre à l'aide de la représentation matricielle des 
*LFSR*, mais cette démonstration dépasse le cadre de cette note.
{{< /admonition >}}

## Représentation sous forme de polynôme

L'existence d'une représentation sous forme de suite d'un *LFSR* implique donc
forcément l'existence d'une représentation sous de série et donc dans certain 
cas de polynôme.

### Polynôme de rétroaction

On définit le **polynôme de rétroaction** d'un *LFSR* de la manière suivante :

\[
  P(X) = 1 - \sum_{i = 1}^l c_i x^i
\]

{{< admonition >}}
Puisque l'on travaille dans \(\mathbb{F}_2\), l'opération de soustraction (-) 
est en réalité équivalente à l'addition (+).
{{< /admonition >}}

### Série génératrice ordinaire

Rappelons que la **série génératrice ordinaire** associée à une suite \(s_n\) 
est définie par :

\[
  S(X) = \sum_{n \geq 0} s_n x^n
\]

{{< admonition >}}
Petit rappel sur les séries : \(S\) est **inversible** si et seulement si 
\(s_0 = 1\).
{{< /admonition >}}

Nous disposons des deux propriétés suivantes concernant \(s_n\) :

1. La suite \(s_n\) est un *LFSR* si et seulement si sa série génératrice peut 
s'écrire sous la forme 
\[
S(X) = \dfrac{P_1(X)}{P_2(X)},
\]
où \(P_1(X)\) et \(P_2(X)\) sont deux polynômes.

2. Si \(s_n\) est un *LFSR*, alors il existe une écriture de la forme 
\[
S(X) = \dfrac{Q(X)}{P(X)},
\]
où \(P(X)\) est le **polynôme de rétroaction** et \(Q(X)\) est un polynôme tel que \(\deg Q(X) < l\) (rappelons que \(l\) correspond au nombre de valeurs dans notre boîte à œufs).

### Calcul de \(Q(X)\)

Sans entrer dans les détails de démonstration, il est possible de déterminer \(Q(X)\) à l'aide de la formule suivante :

\[
Q(X) = \sum_{i = 0}^{l - 1} s_i x^i - \sum_{n = 1}^{l - 1} \sum_{\substack{i + j = n\\i \geq 0\\j \geq 1}} s_i c_j x^n
\]

Cette formule peut sembler complexe au premier abord, mais elle est en réalité assez accessible. Prenons un exemple ensemble en reprenant le premier *LFSR* que nous avons examiné :

![Image du premier *LFSR*](https://i.imgur.com/FMELxUF.png)

On dispose alors des informations suivantes :

<table border="1" style="border-collapse: collapse;">
  <tr>
    <th style="text-align: center;">\(i\)</th>
    <th style="text-align: center;">0</th>
    <th style="text-align: center;">1</th>
    <th style="text-align: center;">2</th>
    <th style="text-align: center;">3</th>
    <th style="text-align: center;">4</th>
    <th style="text-align: center;">5</th>
  </tr>
  <tr>
    <td style="text-align: center;">\(s_i\)</td>
    <td style="text-align: center;">1</td>
    <td style="text-align: center;">0</td>
    <td style="text-align: center;">0</td>
    <td style="text-align: center;">1</td>
    <td style="text-align: center;">1</td>
    <td style="text-align: center;"></td>
  </tr>
  <tr>
    <td style="text-align: center;">\(c_i\)</td>
    <td style="text-align: center;"></td>
    <td style="text-align: center;">0</td>
    <td style="text-align: center;">1</td>
    <td style="text-align: center;">0</td>
    <td style="text-align: center;">0</td>
    <td style="text-align: center;">1</td>
  </tr>
</table>

On peut aisément calculer la partie gauche de la formule, c'est-à-dire la somme

\[
\sum_{i = 0}^{l - 1} s_i x^i.
\]

Dans notre exemple, cette somme se simplifie en :

\[
1 + x^3 + x^4.
\]

Pour la partie droite, il faut observer que, pour chaque entier \(n\) allant de 
1 à \(l - 1\), on doit sommer les produits \(s_i \times c_j\) pour tous les 
couples d'indices tels que \(i + j = n\). Le résultat de cette somme correspond 
au coefficient de \(x^n\).

Examinons cela pour notre exemple :

| \(n\) | Expression                            | Résultat          |
|-------|---------------------------------------|-------------------|
| 1     | \(s_0c_1\)                           | \(0\)             |
| 2     | \(s_0c_2 + s_1c_1\)                   | \(1 + 0 = 1\)     |
| 3     | \(s_0c_3 + s_1c_2 + s_2c_1\)           | \(0 + 0 + 0 = 0\) |
| 4     | \(s_0c_4 + s_1c_3 + s_2c_2 + s_3c_1\)   | \(0 + 0 + 0 + 0 = 0\) |

La somme de droite s'exprime donc comme :

\[
x^2.
\]

En combinant les deux parties — en rappelant que dans \(\mathbb{F}_2\) la soustraction est équivalente à l'addition — on obtient :

\[
Q(X) = 1 + x^3 + x^4 + x^2 = 1 + x^2 + x^3 + x^4.
\]