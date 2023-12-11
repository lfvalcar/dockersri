#!/bin/bash
# Script de inicio del servicio DNS

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS_BASE}/start.sh 'DHCP LOG' 'INFORME DE DEL CONTENEDOR DHCPSRV' $DHCP_LOG

# Traer funciones
source "${SCRIPTS_DHCP}/configDHCP.sh"
source /root/scripts/genlogs.sh

mainDHCP(){ # Función principal de configuración del servicio DNS
    genlogsection "$2" $DHCP_LOG

    configDHCP
    resultadoConfigDHCP=$?
    if [ $resultadoConfigDHCP -eq 0 ]
    then
        echo "<tr id=normal><td>$(date)</td>" >> $DHCP_LOG
        echo '<td>Servicio DHCP configurado y ejecutado con éxito</td></tr></table>' >> $DHCP_LOG
        genlogfinally
        /usr/sbin/dhcpd -f --no-pid -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases -user dhcpd -group dhcpd eth0 # Ejecución del servicio
    fi
}

mainDHCP 'DHCP LOG' 'INFORME DE DEL CONTENEDOR DHCPSRV'