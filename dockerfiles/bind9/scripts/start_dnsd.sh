#!/bin/bash
# Script de inicio del servicio DNS

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS}/start.sh

# Traer funciones
source "${SCRIPTS}/configDNS.sh"
source "${SCRIPTS}/genlogs.sh"

mainDNS(){ # Función principal de configuración del servicio DNS
    genlogsection
    
    configDNS
    resultadoConfigDNS=$?
    if [ $resultadoConfigDNS -eq 0 ]
    then 
        echo "<tr id=normal><td>$(date)</td>" >> $LOG   
        echo '<td>Servicio DNS configurado y ejecutado con éxito</td></tr></table>' >> $LOG    
        genlogfinally $LOG
        /usr/sbin/named -f -c /etc/bind/named.conf -u bind # Ejecución del servicio
    fi
}

mainDNS