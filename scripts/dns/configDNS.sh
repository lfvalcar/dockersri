#!/bin/bash
# Script de configuración del servicio DNS

set -e # Carga de las variables de entorno

configDNS(){ # Función de configuración del servicio DNS
    chown bind:bind /var/cache/bind -R
    chown bind:bind /etc/bind/rndc.key
    chgrp bind /etc/bind -R
    
    named-checkconf -z # Comprobar la configuración de todas las zonas
    resultadoNamed=$?

    if [ $resultadoNamed != 0 ] # Control de errores
    then   

        echo 'Hay errores en la configuración de las zonas'
        return 1
    else 
        return 0
    fi
}