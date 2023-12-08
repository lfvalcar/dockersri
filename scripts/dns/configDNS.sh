#!/bin/bash
# Script de configuración del servicio DNS

set -eu # Seguimiento de errores de las variables y carga de las variables de entorno

configDNS(){ # Función de configuración del servicio DNS
    named-checkconf -z # Comprobar la configuración de todas las zonas
    resultadoNamed=$?
    touch /root/prueba.txt
    echo 'No ejecutado' > /root/prueba.txt

    if [ $resultadoNamed != 0 ] # Control de errores
    then   
        echo 'No ejecutado' > /root/prueba.txt
        echo 'Hay errores en la configuración de las zonas'
        return 1
    else 
        echo 'Ejecutado' > /root/prueba.txt
        /usr/sbin/named -f -c /etc/bind/named.conf -u bind & # Ejecución del servicio
        
        # Una vez ejecutado el servicio se comprueban las resoluciones
        dig @127.0.0.1 dns.cicloasir.icv # Comprobar la resolución directa
        resultadoDirecta=$?

        dig @127.0.0.1 -x 172.9.10.2 # Comprobar la resolución inversa
        resultadoInversa=$?

        if [ $resultadoDirecta != 0 ]
        then
            echo 'Error en la resolución directa'
            return 1
        elif [ $resultadoInversa != 0 ]
        then
            echo 'Error en la resolución inversa'
            return 1
        else
            echo 'Éxito en las resoluciones'
            return 0
        fi
    fi
}