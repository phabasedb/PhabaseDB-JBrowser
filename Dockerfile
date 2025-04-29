# PHABASEDB-JBrowse/Dockerfile
FROM nginx:stable-alpine

# Copiamos la carpeta jbrowse2/ al directorio estático de Nginx
COPY jbrowse2/ /usr/share/nginx/html/

# Exponemos el puerto 80 de Nginx (luego lo mapeamos como 5000)
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
