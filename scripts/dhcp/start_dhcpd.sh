#!/bin/bash
# Script de inicio del servicio DNS

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS_BASE}/start.sh 'DHCP LOG' 'INFORME DE DEL CONTENEDOR DHCPSRV' $DHCP_LOG

# Traer funciones
source "${SCRIPTS_DHCP}/configDHCP.sh"
source /root/scripts/genlogs.sh

mainDHCP(){ # Función principal de configuración del servicio DNS
    configDHCP
    resultadoConfigDHCP=$?
    if [ $resultadoConfigDHCP -eq 0 ]
    then    
        echo 'Servicio DHCP configurado y ejecutado con éxito'
        /usr/sbin/dhcpd  -f --no-pid -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases -user dhcpd -group dhcpd eth0 # Ejecución del servicio
    fi
}

mainDHCP 