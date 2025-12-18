# Builder
FROM hugomods/hugo AS builder
WORKDIR /src
COPY . .
RUN hugo --destination public

# Production
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /src/public /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html
EXPOSE 80
