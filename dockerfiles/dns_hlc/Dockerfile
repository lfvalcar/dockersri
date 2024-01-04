# Dockerfile para el servicio DNS
# Partimos de la imagen base de debian
FROM lfvalcar/deb-base

# Argumentos
ARG DNS_PORT
ARG DNS_DOCKERFILE
ARG IDRSA

# PAQUETERÍA
# Instalación de los paquetes necesarios para el servicio
RUN apt install -yq --no-install-recommends \
    # Servicio DNS
    bind9 \
    dnsutils \
    geoip-bin \
    # Eliminar paquetes huérfanos
    && apt autoremove -yq \
    # Limpiar caché de apt
    && apt clean -yq

# Copiado de la clave RSA
COPY ${IDRSA} /root

# Trabajar en la carpeta scripts
WORKDIR /root/scripts

# SCRIPTS DE CONFIGURACIÓN
# Copiar los scripts al contenedor

# Configuración del servicio
COPY ${DNS_DOCKERFILE}/scripts/* ./

# Conceder permisos de ejecución a los scripts
RUN chmod u+x ./* -R

# Carpeta de configuración del servicio
COPY ${DNS_DOCKERFILE}/bind /etc/bind

# Exponer puertos DNS
EXPOSE ${DNS_PORT}
EXPOSE ${DNS_PORT}/udp

# Ejecutar el script de inicialización del servicio DNS
ENTRYPOINT [ "/root/scripts/start_dnsd.sh" ]