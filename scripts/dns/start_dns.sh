#!/bin/bash
# Script de inicio del servicio DNS

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash "${SCRIPTS_BASE}/start.sh"

# Traer funciones
source "${SCRIPTS_DNS}/configDNS.sh"

mainDNS(){ # Función principal de configuración del servicio DNS
    configDNS
    resultadoConfigDNS=$?
    if [ $resultadoConfigDNS -eq 0 ]
    then    
        echo 'Servicio DNS configurado y ejecutado con éxito'
        /usr/sbin/named -g -c /etc/bind/named.conf -u bind # Ejecución del servicio
    else
        echo 'Error en el proceso de configuración del servicio DNS'
    fi
}

mainDNS