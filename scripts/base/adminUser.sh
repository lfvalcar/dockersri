#!/bin/bash
# Script de creación del usuario administrador en la imagen base

set -eu # Seguimiento de errores de las variables y carga de las variables de entorno

adminUser(){ # Función que crea el usuario administrador del sistema base
        if [ $(grep -c ${ADMIN_USER} /etc/passwd) -eq 1 ] # Comprobar de que el usuario no exista mirando en el registro de usuarios
        then 
            echo "El usuario ${ADMIN_USER} existe"
            return 1 # Error inesperado
        elif [ -d /home/${ADMIN_USER} ]
        then
            echo "El directorio home de ${ADMIN_USER} existe"
            return 1 # Error inesperado
        else
            useradd -m -s /bin/bash -g sudo ${ADMIN_USER} # Crear el usuario administrador
            echo "${ADMIN_USER}:${ADMIN_PASSWORD}" | chpasswd # Establecer la contraseña para el usuario administrador
            passwd -l root # Bloquear la cuenta root
            return 0 # Usuario administrador creado con éxito
        fi
}