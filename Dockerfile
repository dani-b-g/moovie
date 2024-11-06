# Etapa 1: Construcción
FROM node:20-alpine AS builder
USER root
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Servir desde Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Copia el archivo de configuración personalizado
COPY nginx-custom.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
