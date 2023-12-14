#!/bin/bash
# Script de inicio del servicio DNS

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS}/start.sh

# Traer funciones
source "${SCRIPTS}/configDHCP.sh"
source "${SCRIPTS}/genlogs.sh"

mainDHCP(){ # Función principal de configuración del servicio DNS
    configDHCP
    resultadoConfigDHCP=$?
    if [ $resultadoConfigDHCP -eq 0 ]
    then
        echo "<tr id=normal><td>$(date)</td>" >> $LOG
        echo '<td>Servicio DHCP configurado y ejecutado con éxito</td></tr>' >> $LOG
        genlogfinally
        /usr/sbin/dhcpd -f --no-pid -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases -user dhcpd -group dhcpd eth0 # Ejecución del servicio
    fi
}

mainDHCP