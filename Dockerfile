# Construir a aplicação React
FROM node:alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# Configurar o estágio de produção
FROM node:alpine
WORKDIR /app
COPY --from=build-stage /app/build ./build
COPY package*.json ./
COPY server.js ./
RUN npm install express

CMD ["node", "server.js"]