#!/bin/bash
# Script de inicio de la imagen base

set -e # Carga de las variables de entorno

# Traer las funciones
source "${SCRIPTS}/genlogs.sh"
source "${SCRIPTS}/adminUser.sh"
source "${SCRIPTS}/configSSH.sh"

main(){ # Función principal
    genlogheader
    genlogsection

    adminUser # Función creación de usuario administrador
    resultadoAdminUser=$? # Resultado de la función anterior
    if [ $resultadoAdminUser -eq 0 ] 
    then
        # Éxito
        echo "<tr id=normal><td>$(date)</td>" >> $LOG
        echo '<td>Proceso de creación del usuario administrador completado</td></tr>' >> $LOG
        configSSH $LOG # Función de configuración del servicio SSH
        resultadoConfigSSH=$? # Resultado de la función anterior
        if [ $resultadoConfigSSH -eq 0 ]
        then
            # Éxito
            echo "<tr id=normal><td>$(date)</td>" >> $LOG
            echo '<td>Servicio SSH configurado y ejecutado con éxito, proceso completado</td></tr></table>' >> $LOG
            /usr/sbin/sshd -D & # Ejecución del servicio SSH en segundo plano
        fi
    fi
}

main