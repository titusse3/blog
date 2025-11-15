---
title: Fonctionnal Reactive Programming (FRP)
date: "2025-10-14"
categories: [Haskell, FRP, Obelisk]
---

Aillant fais quelques projets en Haskell, j'ai eu l'opportunité de travailler sur la mise en place d'un site web aillant pour thechnologie de base le **FRP**.

Il s'agit d'un paradigme de programmation fonctionnelle permettant de gérer des systèmes réactifs et interactifs. Il est souvent utilisé pour mettre en place des interfaces graphiques, cependant, il s'agit d'une approche qui peut être généralisée.

## Techno disponible

Dans le cadre du développement web, la bibliothèque la plus utiliser est **Reflex**. Il s'agit d'une bibliothèque **FRP** dédiée au Frontend.
Il est possible de transpiler le code **Haskell** en **JavaScript** via **GHCJS**.
Cependant, il existe un framework complet nommé **Obelisk** qui permet de gérer la partie Frontend et Backend en **Haskell** en une seul codebase.
Ces deux choix on leur avantages et inconvénients :

| GHCJS + Reflex | Obelisk |
|----------------|---------|
| Plus léger     | Plus complet |
| Utilisable à l'aide de **GHCJS** | Sur couche en **nix** |
| Compilation en **JavaScript** | Cross platforme disponible (web, ios, android) |
| Nécessite de gérer le Backend séparément | Backend en **Haskell** intégré |

Pour plus d'information sur la mise en place de **Reflex** avec **GHCJS**, vous pouvez consulter [cet article](https://cah6.github.io/technology/nix-haskell-3/).

# Références

- [Reflex + GHCJS](https://cah6.github.io/technology/nix-haskell-3/)