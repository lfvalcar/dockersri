#!/bin/bash
# Script de inicio de la imagen base

set -e # Carga de las variables de entorno

# Traer las funciones
source "${SCRIPTS_BASE}/adminUser.sh"
source "${SCRIPTS_BASE}/configSSH.sh"

main(){ # Función principal
    adminUser # Función creación de usuario administrador
    resultadoAdminUser=$? # Resultado de la función anterior
    if [ $resultadoAdminUser -eq 0 ] 
    then
        # Éxito
        echo 'Usuario administrador creado con éxito, damos paso a la configuración SSH...'
        configSSH # Función de configuración del servicio SSH
        resultadoConfigSSH=$? # Resultado de la función anterior
        if [ $resultadoConfigSSH -eq 0 ]
        then
            # Éxito
            echo 'Servicio SSH configurado y ejecutado con éxito, proceso completado'
            /usr/sbin/sshd -D & # Ejecución del servicio SSH en segundo plano
        else   
            # Error 
            echo 'Error en el proceso de configuración del servicio SSH'
        fi
    else
        # Error 
        echo 'Error en el proceso de creación del usuario administrador'
    fi
}

main