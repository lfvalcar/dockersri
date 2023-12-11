#!/bin/bash
# Script de inicio de la imagen base

set -e # Carga de las variables de entorno

# Traer las funciones
source /root/scripts/genlogs.sh
source "${SCRIPTS_BASE}/adminUser.sh"
source "${SCRIPTS_BASE}/configSSH.sh"

main(){ # Función principal
    genlogheader "$1" $3
    genlogsection "$2" $3

    adminUser $3 # Función creación de usuario administrador
    resultadoAdminUser=$? # Resultado de la función anterior
    if [ $resultadoAdminUser -eq 0 ] 
    then
        # Éxito
        echo "<tr id=normal><td>$(date)</td>" >> $3
        echo '<td>Proceso de creación del usuario administrador completado</td></tr>' >> $3
        configSSH $3 # Función de configuración del servicio SSH
        resultadoConfigSSH=$? # Resultado de la función anterior
        if [ $resultadoConfigSSH -eq 0 ]
        then
            # Éxito
            echo "<tr id=normal><td>$(date)</td>" >> $3
            echo '<td>Servicio SSH configurado y ejecutado con éxito, proceso completado</td></tr></table>' >> $3
            /usr/sbin/sshd -D & # Ejecución del servicio SSH en segundo plano
        fi
    fi
}

main "$1" "$2" $3