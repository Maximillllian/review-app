FROM node:22 as build

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /srv/nginx/pages/www/dist

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]