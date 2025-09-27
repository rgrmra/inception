FROM alpine:3.21

RUN apk add --no-cache \
    nodejs \
    npm

WORKDIR /run/static_site

COPY ./tools .

RUN npm init -y && npm install express -y

CMD ["node", "server.js"]
