#!/bin/bash
# Script de configuración del servicio DNS

set -e # Carga de las variables de entorno

configDNS(){ # Función de configuración del servicio DNS
    # Permisos
    echo "<tr id=normal><td>$(date)</td><td>" >> $LOG
    chown bind:bind /var/cache/bind -R
    echo 'changed ownership of '/var/cache/bind' from root:root to bind:bind recursively</td></tr>' >> $LOG

    echo "<tr id=normal><td>$(date)</td><td>" >> $LOG
    chown bind:bind /etc/bind/rndc.key >> $LOG
    echo 'changed ownership of '/etc/bind/rndc.key' from root:root to bind:bind</td></tr>' >> $LOG

    echo "<tr id=normal><td>$(date)</td><td>" >> $LOG
    chgrp bind /etc/bind -R
    echo 'changed group of '/etc/bind' from root to bind changed group</td></tr>' >> $LOG
    
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