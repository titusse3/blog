---
title: TOTP protocole
date: "2025-11-15"
categories: [Cryptographie]
---

Le protocle **TOTP** (Time-based One-Time Password) est devenu une option générique pour la **2FA** sur pratiquement toutes les plateformes métant cette double authentification en place. 

Cette note à pour but de présenter le fonctionnement de ce protocole.

<!--more-->

{{< admonition >}}
Bien que **OTP**, One-Time Password et One-Time Pad soient des acronymes similaires, ils ne désignent pas la même chose. Le One-Time Pad, aussi appeler chiffrement de Vernam est un protocole de chiffrement. 

La où le One-Time Password est un protocole d'authentification. Il ne faut donc pas confondre les deux.
{{< /admonition >}}

# Principe

Le protocole **TOTP** à pour but de mettre en place un mots de passe à usage valable seulement pendant une courte période de temps. Ce mot de passe est généré à partir de l'heure ainsi qu'une clé secrète partagée entre le client et le service surlequel l'utilisateur souhaite s'authentifier. 

Le 'sous-mot de passe' est généré par un appareil (souvent une application mobile), de ce faite, la clé secrète est stockée sur cet appareil.

Les applications les plus utilisées sont les suivantes :
- Google Authenticator (Propriétaire)
- Aegis Authenticator (Open Source et libre)
- FreeOTP (Open Source et libre)

# Sécurité

Comme dis précédement, l'utilisateur détient une clé secrète partagée avec le service. De cette façon, le service peut donc vérifier que le 'sous-mot de passe' généré par l'utilisateur est bien valide.

Ce qui est très intéressant avec ce protocole, c'est que la clé secrète n'est jamais transmise lors de l'authentification. Seul le mot de passe à usage unique est transmis. Or, si ce mot de passe est intercepté, il ne sera plus valide après un court laps de temps (généralement 30 secondes).

Ce qu'il faut donc comprendre et que la manière dont la clé secrète est protégée
que ce soit sur le service ou sur l'appareil de l'utilisateur est cruciale pour la sécurité du protocole.

![Schéma du protocole TOTP](https://i.imgur.com/pb7pz5H.gif)