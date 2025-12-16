# Blog

## Important

Le blog ne peut être utilisé qu'avec des versions de `Hugo` supérieures ou égales à `0.140`.

## Git clone

Le site utilise un theme `Hugo` personnalisé. Pour cloner le dépôt, utilisez la commande suivante :

```bash
git clone --recurse ...
```

## Note :

### Note d'admonition

![Exemple d'admonition](./img_readme/admonition.png)

```
{{< admonition >}}
...
{{< /admonition >}}
```

### Info d'admonition

![Exemple d'info](./img_readme/info.png)

```
{{< admonition type="info" >}}
...
{{< /admonition >}}
```

### Tip d'admonition

![Exemple de tip](./img_readme/tip.png)

```
{{< admonition type="tip" >}}
...
{{< /admonition >}}
```

### Warning d'admonition

![Exemple de warning](./img_readme/warning.png)

```
{{< admonition type="warning" >}}
...
{{< /admonition >}}
```

### Danger d'admonition

![Exemple de danger](./img_readme/danger.png)

```
{{< admonition type="danger" >}}
...
{{< /admonition >}}
```

### Backlink

Permet d'ajouter un lien vers un autre article.

```
{{< backlink "nom-du-fichier" "titre personnalisé" >}}
```

### SideNote

![Exemple de sidenote](./img_readme/sidenote.png)

```
{{< sidenote "¹" >}}Voici le contenu de ma note qui s'affichera sur le côté.{{< /sidenote >}}
```