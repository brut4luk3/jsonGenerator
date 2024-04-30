FROM node:alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:alpine
WORKDIR /app
COPY --from=build-stage /app/build ./build
COPY package*.json ./
COPY server.js ./
RUN npm install express

CMD ["node", "server.js"]