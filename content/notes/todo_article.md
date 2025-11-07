---
title: "Manageur de tâches self host"
date: "2025-10-07"
tags: [Home Lab, Kanban Chart]
categories: [Home lab]
ShowToc: true
---

# Kanban Chart

J’ai eu la chance d’assister à une conférence sur la gestion du temps, organisée pour les étudiants membres d’une association. Parmi les outils et conseils présentés, celui qui m’a le plus marqué, c’est la mise en place d’un **Kanban Board**. Une méthode visuelle pour organiser et fragmenter ses tâches, suivre sa progression et rester motivé au quotidien.

![Exemple de Kanban Chart](https://i.imgur.com/UerKINV.jpeg#center)
*Exemple de **Kanban Chart** pour la gestion d'un projet de dévellopement.*

Il s’agit d’une méthode de gestion de projet visant à classer et organiser les tâches. Simple à mettre en place, elle peut aussi être appliquée à la gestion de tâches personnelles, pour mieux planifier son travail.

## Classification de tâches

Pour la gestion de tâches personnelles :

- **Tâches instantanées** : tâches qui prennent moins de 5 minutes à réaliser.

- **Tâches rapides** : tâches de 10 à 30 minutes. Parfait pour avancer sur des points précis sans y consacrer une demi-journée.

- **Tâches coûteuses** : tâches plus longues, de 30 minutes à 1h30. Ces tâches demandent plus de concentration et peuvent nécessiter un bloc de temps dédié.

- **Backlog** : liste de tâches que l’on garde en tête pour les réaliser dès que possible. Cela permet de ne rien oublier et de prioriser selon son emploi du temps.

- **Sources / bibliographie** : ensemble de ressources, articles ou références que l’on conserve.

Pour ce qui va être des tâches `instantaner`, il faut les faire directements, sans les plannifiers. De façon à ne pas les repoussers.
Pour les autres taches, elle doivent être classer, notament à l'aide des `Tags`.

De la même manière, il est important de prendre en compte l’ordre des tâches, c’est-à-dire leur position verticale dans le Kanban ainsi que leur date. L’ordre permet de prioriser visuellement les tâches et de savoir rapidement lesquelles doivent être traitées en premier.

## Tag

Chaque tâche peut être associée à un ou plusieurs tags. Ces tags permettent notamment de :

- Catégoriser les tâches par type ou par projet
- Faciliter le filtrage et la recherche dans le Kanban

# Mise en place du service

Ce type de gestion de tâches peut être facilement mis en place sur des plateformes telles que **Notion** ou **Obsidian**. Cependant, il est important de garder à l’esprit que ces services utilisent les données des utilisateurs à leur manière et peuvent poser des questions de confidentialité.

Pour cela, une solution de *self-hoste* s’avère particulièrement intéressante. De plus, la gestion des tâches gagne à être intégrée à un gestionnaire d’agenda. Cela permet de :

- Relier les tâches à des alertes pour ne rien oublier
- Définir des périodes de résolution afin de planifier efficacement le temps nécessaire à leur réalisation

La façon la plus courante, en tous cas la plus commune est d'utilier **NextCloud**. Notamment avec l'application **Tasks** qui permet de gérer les tâches en Kanban et de les synchroniser. Cependant, la mise en place de **NextCloud** est lourde et consommatrice en ressources. Etant donner que pour utiliser un service **NextCloud**, il faut installer l'ensemble de la suite.

La *{{< sidenote "stack" >}}Ensemble d'applications mises bout à bout pour répondre à un problème{{< /sidenote >}}* que j'ai mis en place est basé sur le protocole **CalDav**. 

{{< admonition >}}
La solution de **NextCloud** aurait elle aussi utiliser ce protocole. Cependant, celle proposée ici est plus légère, étant une solution bien plus spécialisée à la tache à accomplir.
{{</ admonition >}}

## Protocole CalDav

Le protocole **CalDav** est un standard ouvert qui permet la gestion des calendriers et des tâches via Internet. Bien qu'utilisé, il est énormément décrié par sa complexité et sa mauvaise documentation. C'est l'une des raisons pour lesquelles peu de services sont disponibles pour héberger un serveur **CalDav**.

L'une des seules applications qui ne fessait que la mise en place d'un server **CalDav** est **Radicale**. Après une installation très simple part **docker**, il suffit de configurer un client **CalDav** pour se connecter au serveur.
Le client que j'utilise est **Thunderbird**. En effet, en important le calendrier **CalDav** dans **Thunderbird**, les taches sont automatiquement récupérées par le client.

{{< admonition >}}
Le service **Radicale** est un server et uniquement un server **CalDav**. Aucune *WebUi* ou interface graphique n'est fournie par **Radicale**.
{{< /admonition >}}

Une image de cette stack est visible ci-dessous :

![Schema stack CalDav](https://i.imgur.com/w1HOknI.jpeg#center)