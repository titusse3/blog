# Builder
FROM hugomods/hugo AS builder
WORKDIR /src
COPY . .
RUN hugo --panicOnWarning --destination public

# Production
FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY --from=builder /src/public /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html
EXPOSE 80
