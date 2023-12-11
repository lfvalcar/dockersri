#!/bin/bash
# Script de inicio del servicio DNS

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS_BASE}/start.sh 'LOG DNSSRV' 'INFORME DEL CONTENEDOR DNSSRV' $DNS_LOG

# Traer funciones
source "${SCRIPTS_DNS}/configDNS.sh"
source "${SCRIPTS_GEN_LOGS}/genlogs.sh"

mainDNS(){ # Función principal de configuración del servicio DNS
    genlogsection "$1" $DNS_LOG
    
    configDNS
    resultadoConfigDNS=$?
    if [ $resultadoConfigDNS -eq 0 ]
    then 
        echo "<tr id=normal><td>$(date)</td>" >> $DNS_LOG   
        echo '<td>Servicio DNS configurado y ejecutado con éxito</td></tr></table>' >> $DNS_LOG    
        genlogfinally $DNS_LOG
        /usr/sbin/named -f -c /etc/bind/named.conf -u bind # Ejecución del servicio
    fi
}

mainDNS 'INFORME DEL CONTENEDOR DNSSRV'