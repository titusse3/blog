---
title: "Génération Augmentée de récupération (RAG)"
date: "2025-06-10"
tags: [IA, RAG, LLM]
categories: [intelligence artificielle]
series : ["Découverte"]
summary: "Les LLM comme ChatGPT sont puissants, mais limités. Les RAG (Retrieval-Augmented Generation) améliorent leurs réponses en leur fournissant des documents à la volée, sans ré-entraînement. L’article explore les variantes des RAG — naïf, avancé, modulaire — afin de palier aux principaux défauts des LLM modernes."
---
![Illustration imagée d'un **LLM**](https://i.imgur.com/cOkBxoU.jpeg#center)

Les **grands modèles de langues (LLM)** sont très probablement la technologie la plus utilisée de ces cinq dernières années. Introduit au public par son représentant le plus connu [ChatGPT](https://openai.com/index/chatgpt/) en 2022.
Ils sont devenus des outils presque indispensables pour certains.

Bien que ces outils soient très impressionnants, ils admettent encore de nombreux défauts. L'**hallucination**, la **{{< sidenote "Cut-off Date" >}}, date de fin d'entrainement du modèle. Ce qui implique que les informations postérieures à l'entrainement ne seront pas accessibles par le modèle{{< /sidenote >}}**.

# Génération augmentée de récupération (RAG)

Une solution aux problèmes cités ci-dessus peut être vue dans le mécanisme **RAG**. Ce système vise à ajouter des ressources/ connaissances supplémentaires au modèle par le biais de documents. Ce qui est intéressant pour ne pas avoir à re-entrainer un **LLM**, ce qui serait bien trop couteux en ressources. La solution qui implique le ré-entrainement se nomme le *Fine-tunining* mais elle ne sera pas abordée ici.

Le fonctionnement d'un **RAG** se découpe en trois grandes étapes. La première, l'**indexation** (**indexing**) des ressources/ documents ajoutés. Cette phase peut être vue comme une extraction des connaissances présentes dans les documents. De plus, cette extraction est suivie par un rangement aillant pour but de rendre plus rapide leur récupération future. Pour une explication détaillée de cette étape utilisant un **graphe de connaissance (KG)** voir l'article [GraphRAG](google.com), pour l'utilisation d'une **base de données vectorielle** se référer à l'article [VectorRAG](google.com).
Après la phase d'**indexing**, le **RAG** attend maintenant une entrée utilisateur. Une fois cette requête obtenue, on essaye de récupérer dans les ressources indexées, celles qui sont concernées par cette entrée. Une fois ce prompt mis en place, il est envoyer au **LLM**. Un exemple de **RAG** est donné par la figure ci-dessous, celle-ci est la version la plus simple appelée aussi **RAG naïve**.
![Schéma montrant un **RAG naïf**.](https://i.imgur.com/x2l7TxO.jpeg#center)

Les étapes évoquées précédemment sont présentes dans toutes les versions de **RAG**. La suite de cet article correspond à une description des modifications de cette architecture **RAG**.

## Advanced RAG

La différence entre le **naïve RAG** et le *advanced* ne réside que dans l'ajout des étapes de **pre-retrival** et **post-retrival**. L'étape de **pre-retrival** correspond à un prétraitement de la requête de l'utilisateur. Que ce soit pour améliorer les requêtes sur les documents indexés. Où même la rendre plus intéligible pour le **LLM** en passant par du **prompt ingeniering**.

La phase de **post-retrival** correspond quant à elle au filtrage ainsi qu'àla mise en valeur des informations obtenues sur les documents indexés. La figure ci-dessous représente un **Advanced RAG**.

![Schéma d'un **Advanced RAG**](https://i.imgur.com/x08k9Qz.jpeg#center)

## Modular RAG

De la même manière que les **Advandced RAG**, les **Modular RAG**ont pour objectif d'ajouter des étapes à notre mécanisme. Cela va même plus loin, certains supprime/ modifie même certaines étapes des **Naïve RAG**, **Advanced RAG**. Il s'agit du type de **RAG** qui est actuellement le plus utilisé.