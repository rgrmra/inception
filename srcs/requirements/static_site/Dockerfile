FROM alpine:latest

# Cria o diretório do site
RUN mkdir -p /static_site

# Copia os arquivos do site
COPY . /static_site

# Define o diretório de trabalho
WORKDIR /static_site

# Não expõe nenhuma porta ou executa comandos — é só para armazenamento

