#!/bin/bash
# Script de configuración del servicio DNS

set -e # Carga de las variables de entorno

configDNS(){ # Función de configuración del servicio DNS
    # Permisos
    echo "<tr id=normal><td>$(date)</td><td>" >> $LOG
    chown -v bind:bind /var/cache/bind -R >> $LOG
    echo '</td></tr>' >> $LOG

    echo "<tr id=normal><td>$(date)</td><td>" >> $LOG
    chown -v bind:bind /etc/bind/rndc.key >> $LOG
    echo '</td></tr>' >> $LOG

    echo "<tr id=normal><td>$(date)</td><td>" >> $LOG
    chgrp -v bind /etc/bind -R >> $LOG
    echo '</td></tr>' >> $LOG
    
    named-checkconf -z # Comprobar la configuración de todas las zonas
    resultadoNamed=$?

    if [ $resultadoNamed != 0 ] # Control de errores
    then   
        echo "<tr id=error><td>$(date)</td>" >> $LOG
        echo '<td>Hay errores en la configuración de las zonas</td></tr>' >> $LOG
        return 1
    else 
        return 0
    fi
}