# Dockerfile para el servicio HTTP
# Partimos de la imagen base de debian
FROM deb-base  

# Variables de entorno en el dockerfile
ARG HTTP_PORT
ARG HTTP_DOCKERFILE
ARG IDRSA

# PAQUETERÍA
# Instalación de los paquetes necesarios para el servicio
RUN apt install -yq --no-install-recommends \
    # Servicio HTTP
    apache2 \
    apache2-utils \
    # Eliminar paquetes huérfanos
    && apt autoremove -yq \
    # Limpiar caché de apt
    && apt clean -yq

# Copiado de la clave RSA
COPY ${IDRSA} /root

# Trabajar en la carpeta scripts
WORKDIR /root/scripts

# SCRIPTS DE CONFIGURACIÓN
COPY ${HTTP_DOCKERFILE}/scripts/* ./
# Conceder permisos de ejecución a los scripts
RUN chmod u+x ./* -R

# Archivo de configuración del servicio apache2
COPY ${HTTP_DOCKERFILE}/config/000-default.conf /etc/apache2/sites-available
COPY ${HTTP_DOCKERFILE}/config/.htpasswd /etc/apache2

# Exponer puertos HTTP
EXPOSE ${HTTP_PORT}

ENTRYPOINT [ "/root/scripts/start_httpd.sh" ]