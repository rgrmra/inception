FROM alpine:3.22.1

RUN apk add --no-cache \
    wget

WORKDIR /bin

RUN wget https://github.com/google/cadvisor/releases/download/v0.52.1/cadvisor-v0.52.1-linux-amd64 -O cadvisor

RUN chmod +x /bin/cadvisor

CMD [ "/bin/cadvisor" ]
