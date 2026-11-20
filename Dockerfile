ARG NODE_VERSION=node:26.13.1-alpine
ARG NGINX_VERSION=nginx:stable-alpine3.19

FROM $NODE_VERSION as builder
ARG env
WORKDIR /app
COPY . .
RUN npm ci
RUN npx ng build --c=${env} --output-hashing all

FROM $NGINX_VERSION
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist/dc-plus-admin-portal /usr/share/nginx/html
EXPOSE 4200
