FROM node:lts-buster as build-step

LABEL maintainer vito.degirolamo88@gmail.com

WORKDIR /app
COPY . /app/

RUN npm install && npm run build

ENTRYPOINT  [ "npm", "start" ]

FROM nginx

COPY --from=build-step /app/build/ /usr/share/nginx/html