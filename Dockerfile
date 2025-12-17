# Étape 1 : Build du site avec Hugo
FROM hugomods/hugo AS builder
COPY . /src
RUN hugo

# Étape 2 : Serveur de production
FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80