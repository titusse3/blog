---
title: "Développement de série à la main"
date: "2025-03-05"
categories: [Calcule Formelle, Série]
math: true
---

<!--more-->

Dans cet article, nous verrons une méthode permettant de développer la 
composition de deux séries génératrices, que nous noterons \(S \circ T\) à la 
main. Ce développement s’exprime sous la forme :

$$
\sum_{i} s_i \left(\sum_{j} t_j x^j\right)^i.
$$

Pour illustrer cette méthode, nous supposerons que l’objectif est d’obtenir le 
coefficient de \(x^3\) dans ce développement.

---

### Étape 1 : Décomposition de l’exposant

La première étape consiste à décomposer l’exposant trois en sommes d'entiers 
inférieurs ou égaux à 3. Les décompositions possibles sont :

$$
\begin{split}
3 &= 3,\\[1mm]
  &= 1 + 2,\\[1mm]
  &= 1 + 1 + 1.
\end{split}
$$

{{< admonition >}}
Pour vérifier que nous n’avons omis aucune décomposition, voici le nombre de 
décompositions pour les entiers de 1 à 10 :

1, 2, 3, 5, 7, 11, 15, 22, 30, 42.
{{< /admonition >}}
---

### Étape 2 : Expression en termes de \(S \circ T\)

Chaque décomposition permet d’identifier les termes correspondants dans la 
composition des séries. On associe ainsi un coefficient \(s_i\) en fonction du 
nombre de termes de la décomposition, et des produits de coefficients \(t_j\) 
correspondant aux valeurs ajoutées. Plus précisément :

- Pour la décomposition \(3 = 3\), un seul terme est impliqué, ce qui conduit à :
  \[
  s_1(t_3).
  \]
  
- Pour la décomposition \(3 = 1 + 2\), deux termes apparaissent, et l’on écrit :
  \[
  s_2(t_1 \, t_2).
  \]
  
- Pour la décomposition \(3 = 1 + 1 + 1\), trois termes identiques sont 
présents, ce qui donne :
  \[
  s_3(t_1 \, t_1 \, t_1) = s_3(t_1^3).
  \]
  
Ici, \(s_i\) et \(t_j\) sont respectivement les coefficients des séries \(S\) et 
\(T\). Le rang \(i\) de \(s_i\) correspond au nombre de termes dans la 
décomposition, tandis que les indices des \(t_j\) sont choisis pour que la 
somme de ces indices soit égale à 3.

---

### Étape 3 : Incorporation des coefficients binomiaux

Pour tenir compte des différentes permutations des termes dans chaque décomposition, nous introduisons des coefficients multinomiaux. En reprenant les termes obtenus précédemment, nous pouvons écrire :

\[
\begin{aligned}
s_1\Bigl(\binom{1}{1}\, t_3^1\Bigr) &= s_1(t_3),\\[1mm]
s_2\Bigl(\binom{2}{1,1}\, t_1^1\, t_2^1\Bigr) &= s_2(2\,t_1t_2),\\[1mm]
s_3\Bigl(\binom{3}{3}\, t_1^3\Bigr) &= s_3(t_1^3).
\end{aligned}
\]

Ici, dans la notation \(\binom{n}{k_1, k_2, \dots, k_r}\), le nombre \(n\) 
représente le nombre total de termes impliqués dans la décomposition, ce qui 
correspond à l’indice du coefficient \(s_i\). Les \(k_j\) indiquent quant à eux 
les exposants des différents \(t_j\). Par exemple, pour la décomposition 
\(3 = 1 + 2\), nous avons deux termes (donc \(n=2\)) et les exposants 
correspondants sont \(1\) pour \(t_1\) et \(1\) pour \(t_2\), d'où le 
coefficient multinomial \(\binom{2}{1,1} = 2\).

{{< admonition >}}
Il faut se rappeler que :
$$\binom{n}{k_1, k_2, \dots, k_r} = \dfrac{n!}{\prod\limits_{i}^r k_i!}$$
Et que pour \(r = 1\) alors :
$$\binom{n}{k} = \dfrac{n!}{k!(n - k)!}$$
{{< /admonition >}}

---

### Conclusion

En rassemblant l’ensemble des contributions, le développement pour le 
coefficient de \(x^3\) dans la composition \(S \circ T\) s’écrit de la manière 
suivante :

\[
x^3\Bigl[s_1(t_3) + s_2(2t_1t_2) + s_3(t_1^3)\Bigr].
\]

En résumé, cette méthode permet de réaliser le développement de la composition 
de séries à la main. Pour vous exercer, essayez de calculer, de la même manière, 
les coefficients du terme en \(x^4\).

<details>
  <summary>Correction</summary>
  
  **Les décompositions de 4 sont :**
  
  \[
  \begin{aligned}
  4 &= 4,\\[1mm]
    &= 1 + 3,\\[1mm]
    &= 2 + 2,\\[1mm]
    &= 1 + 1 + 2,\\[1mm]
    &= 1 + 1 + 1 + 1.
  \end{aligned}
  \]
  
  **Correspondance avec \(s_i\) et \(t_j\) :**
  
  \[
  \begin{alignat*}{3}
  & 4 && = 4 && \rightsquigarrow s_1(t_4),\\[1mm]
  &   && = 1 + 3 && \rightsquigarrow s_2(t_1\,t_3),\\[1mm]
  &   && = 2 + 2 && \rightsquigarrow s_2(t_2^2),\\[1mm]
  &   && = 1 + 1 + 2 && \rightsquigarrow s_3(t_1^2\,t_2),\\[1mm]
  &   && = 1 + 1 + 1 + 1 && \rightsquigarrow s_4(t_1^4).
  \end{alignat*}
  \]
  
  **Incorporation des coefficients binomiaux :**
  
  \[
  x^4\Bigl[s_1\Bigl(\binom{1}{1}t_4\Bigr) + s_2\Bigl(\binom{2}{1,1}\,t_1\,t_3 + \binom{2}{2}t_2^2\Bigr) + s_3\Bigl(\binom{3}{2,1}t_1^2\,t_2\Bigr) + s_4\Bigl(\binom{4}{4}t_1^4\Bigr)\Bigr].
  \]
  
  En développant ces coefficients, on obtient :
  
  \[
  x^4\Bigl[s_1(t_4) + s_2\bigl(2\,t_1\,t_3 + t_2^2\bigr) + s_3\bigl(3\,t_1^2\,t_2\bigr) + s_4(t_1^4)\Bigr].
  \]
  
</details>