# Dockerfile
FROM nginx:alpine

# Instala herramientas necesarias (curl para verificar descargas)
RUN apk add --no-cache bash curl

# Copia la configuración de Nginx y el script de inicio
COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template
COPY start.sh /usr/local/bin/start.sh

# Da permisos de ejecución al script de inicio
RUN chmod +x /usr/local/bin/start.sh

# Expone el puerto 80
EXPOSE 80

# Inicia el contenedor con el script personalizado
CMD ["/usr/local/bin/start.sh"]
