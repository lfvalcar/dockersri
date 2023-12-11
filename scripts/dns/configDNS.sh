#!/bin/bash
# Script de configuración del servicio DNS

set -e # Carga de las variables de entorno

configDNS(){ # Función de configuración del servicio DNS
    echo "<tr id=normal><td>$(date)</td><td>" >> $DNS_LOG
    chown -v bind:bind /var/cache/bind -R >> $DNS_LOG
    echo '</td></tr>' >> $DNS_LOG
    echo "<tr id=normal><td>$(date)</td><td>" >> $DNS_LOG
    chown -v bind:bind /etc/bind/rndc.key >> $DNS_LOG
    echo '</td></tr>' >> $DNS_LOG
    echo "<tr id=normal><td>$(date)</td><td>" >> $DNS_LOG
    chgrp -v bind /etc/bind -R >> $DNS_LOG
    echo '</td></tr>' >> $DNS_LOG
    
    named-checkconf -z # Comprobar la configuración de todas las zonas
    resultadoNamed=$?

    if [ $resultadoNamed != 0 ] # Control de errores
    then   
        echo "<tr id=error><td>$(date)</td>" >> $DNS_LOG
        echo '<td>Hay errores en la configuración de las zonas</td></tr>' >> $DNS_LOG
        return 1
    else 
        return 0
    fi
}