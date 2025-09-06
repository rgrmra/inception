FROM alpine:3.22.1

RUN apk update && apk add wget

WORKDIR /usr/bin

RUN wget https://github.com/google/cadvisor/releases/download/v0.52.1/cadvisor-v0.52.1-linux-amd64 -O cadvisor

RUN chmod +x cadvisor

CMD [ "cadvisor" ]
