FROM alpine:3.21

RUN apk add --no-cache \
	python3 \
	py3-pip

WORKDIR /run/static_site

COPY ./tools ./

RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

RUN mv docker-entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

CMD [ "/run/static_site/entrypoint.sh" ]

