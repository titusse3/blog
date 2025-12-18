# Étape 1 : Builder
FROM hugomods/hugo AS builder
WORKDIR /src
COPY . .
RUN hugo --destination public

# Étape 2 : Serveur de production
FROM nginx:alpine
# ON SUPPRIME TOUT LE CONTENU PAR DÉFAUT ICI
RUN rm -rf /usr/share/nginx/html/*
# ON COPIE TON SITE
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
