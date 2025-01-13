# Use uma imagem base do Nginx para servir a página
FROM nginx:latest

# Copie o arquivo index.html para o diretório padrão do Nginx
COPY index.html /usr/share/nginx/html/index.html

# Exponha a porta 80 para acesso à aplicação
EXPOSE 80

# O Nginx vai rodar por padrão, então não é necessário comando adicional
CMD ["nginx", "-g", "daemon off;"]
