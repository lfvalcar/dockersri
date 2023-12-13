# Dockerfile para el servicio DHCP
# Partimos de la imagen base de debian
FROM deb-base  

# Variables de entorno en el dockerfile
ENV DHCP_PORT=67

# PAQUETERÍA
# Instalación de los paquetes necesarios para el servicio
RUN apt install -yq --no-install-recommends \
    # Servicio DHCP
    isc-dhcp-server \
    dhcping \
    dhcpd-pools \
    # Eliminar paquetes huérfanos
    && apt autoremove -yq \
    # Limpiar caché de apt
    && apt clean -yq

# Trabajar en la carpeta scripts
WORKDIR /root/scripts

# SCRIPTS DE CONFIGURACIÓN
# Copiar los scripts al contenedor

# Configuración del servicio
COPY ./scripts/dhcp ./dhcp
# Conceder permisos de ejecución a los scripts
RUN chmod u+x ./* -R

# Archivo de configuración del servicio DHCP
COPY ./config/dhcpd.conf /etc/dhcp

# Exponer puertos DHCP
EXPOSE ${DHCP_PORT}/udp

# Ejecutar el script de inicialización del servicio DHCP
ENTRYPOINT [ "/root/scripts/dhcp/start_dhcpd.sh" ]