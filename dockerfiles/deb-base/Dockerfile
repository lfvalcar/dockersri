# Dockerfile imagen base de debian
FROM debian

# Variables de entorno en el dockerfile
ENV TZ Europe/Madrid
ENV DEBIAN_FRONTEND noninteractive

# Establecer la zona horaria
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# PAQUETERÍA
# Actualizar lista de paquetes, actualizar paquetes y instalación de los paquetes bases
RUN apt update && apt upgrade -y && apt install -yq --no-install-recommends \
    # Utilidades
    apt-utils \
    # Gestión de ficheros
    tree \
    locate \
    vim \
    # Seguridad
    sudo \
    # Red
    iputils-ping \
    iproute2 \
    openssh-server \
    iptables \
    iptables-persistent \
    net-tools

# Trabajar en la carpeta /root
WORKDIR /root

# Crear los directorios para el almacenaje de los logs y los scripts de configuración
RUN mkdir logs scripts

# SCRIPTS DE CONFIGURACIÓN
# Copiar los scripts de configuración base al contenedor
COPY ./scripts/* ./scripts/

# Exponer puerto ssh
EXPOSE ${SSH_PORT}