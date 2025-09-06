FROM alpine:latest

RUN apk add nodejs npm

COPY ./tools /home/app

WORKDIR /home/app

RUN npm init -y && npm install express -y

CMD ["node", "server.js"]
