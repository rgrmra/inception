FROM alpine:3.22.1

RUN apk update apk add nodejs npm

COPY ./tools /home/app

WORKDIR /home/app

RUN npm init -y && npm install express -y

CMD ["node", "server.js"]
