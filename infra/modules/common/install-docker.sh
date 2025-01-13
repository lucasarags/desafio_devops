#!/bin/bash

# Atualizando pacotes
sudo yum update -y

# Instalando Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Adicionando o usuário `ec2-user` ao grupo `docker` (caso seja necessário)
sudo usermod -aG docker ec2-user

# Instalando Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.19.1/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# Configurando a aplicação
APP_DIR="/app"
DOCKER_COMPOSE_FILE="/app/docker-compose.yml"

# Criando diretório da aplicação
sudo mkdir -p $APP_DIR

# Baixando arquivos da aplicação (substitua este passo por uma abordagem adequada)
sudo yum install -y git
sudo git clone https://github.com/lucasarags/desafio_devops.git $APP_DIR

# Subindo a aplicação com Docker Compose
cd $APP_DIR$APP_DIR
sudo /usr/local/bin/docker-compose up -d

