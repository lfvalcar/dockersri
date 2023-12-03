#!/bin/bash
# Script de inicio de la imagen base

set -eu # Seguimiento de errores de las variables y carga de las variables de entorno

# Traer las funciones
source /root/scripts/adminUser.sh
source /root/scripts/configSSH.sh

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