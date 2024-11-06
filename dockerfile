# Imagen base de Node.js
FROM node:20-alpine AS builder

# Directorio de trabajo
WORKDIR /app

# Copia el package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el código fuente
COPY . .

# Construye la aplicación
RUN npm run build

# Crea una imagen ligera para servir los archivos estáticos
FROM node:20-alpine

# Copia los archivos construidos
COPY --from=builder /app/dist /app

# Instala vite globalmente para `vite preview`
RUN npm install -g vite

# Expone el puerto
EXPOSE 4173

# Comando de inicio
CMD ["vite", "preview", "--port", "4173"]
