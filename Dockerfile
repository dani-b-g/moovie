# Etapa 1: Construcción
FROM node:20-alpine AS builder
USER root
# Crea el directorio de trabajo
WORKDIR /app

# Copia package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todo el código fuente al contenedor
COPY . .
USER 1001
# Construye la aplicación
RUN npm run build
USER root
# Etapa 2: Servir desde Nginx
FROM nginx:alpine

# Copia los archivos estáticos de la etapa de construcción a la raíz de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 80

# Comando de inicio
CMD ["nginx", "-g", "daemon off;"]
USER 1001
