#!/bin/bash
# start.sh

# Verifica que las variables de entorno estén definidas
if [[ -z "$COS_ENDPOINT" || -z "$COS_BUCKET" || -z "$COS_OBJECT" ]]; then
  echo "ERROR: Las variables COS_ENDPOINT, COS_BUCKET y COS_OBJECT deben estar definidas."
  exit 1
fi

# Sustituye las variables en la plantilla de configuración
envsubst '${COS_ENDPOINT} ${COS_BUCKET} ${COS_OBJECT}' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Inicia Nginx
nginx -g "daemon off;"
