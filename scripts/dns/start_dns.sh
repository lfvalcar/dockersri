#!/bin/bash
# Script de inicio del servicio DNS

set -eu # Seguimiento de errores de las variables y carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash /root/start.sh
# Traer funciones
source /root/scriptsDNS/configDNS.sh

main(){ # Función principal de configuración del servicio DNS
    configDNS
    resultadoConfigDNS=$?
    if [ $resultadoConfigDNS -eq 0 ]
    then    
        echo 'Servicio DNS configurado y ejecutado con éxito'
    else
        echo 'Error en el proceso de configuración del servicio DNS'
    fi
}

main