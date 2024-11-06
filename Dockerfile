# Etapa 1: Construcción
FROM node:20-alpine AS builder

# Usa root para evitar problemas de permisos
USER root

# Crea el directorio de trabajo
WORKDIR /app

# Copia package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todo el código fuente al contenedor
COPY . .

# Construye la aplicación (con permisos root)
RUN npm run build

# Etapa 2: Servir desde Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Otorga permisos de escritura a Nginx para el directorio de caché
RUN mkdir -p /var/cache/nginx/client_temp && chown -R 1001:0 /var/cache/nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

USER 1001
