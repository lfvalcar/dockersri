#!/bin/bash
# Script de creación del usuario administrador en la imagen base

set -e # Carga de las variables de entorno

adminUser(){ # Función que crea el usuario administrador del sistema base
        if [ $(grep -c ${ADMIN_USER} /etc/passwd) -eq 1 ] # Comprobar de que el usuario no exista mirando en el registro de usuarios
        then
            echo "<tr id=error><td>$(date)</td>" >> $LOG
            echo "<td>El usuario ${ADMIN_USER} existe</td></tr>" >> $LOG
            return 1 # Error inesperado
        elif [ -d /home/${ADMIN_USER} ]
        then
            echo "<tr id=error><td>$(date)</td>" >> $LOG
            echo "<td>El directorio home de ${ADMIN_USER} existe</td></tr>" >> $LOG
            return 1 # Error inesperado
        else
            echo "<tr id=normal><td>$(date)</td>" >> $LOG
            echo "<td>Usuario ${ADMIN_USER} creado con éxito</td></tr>" >> $LOG
            useradd -m -s /bin/bash -g sudo ${ADMIN_USER} # Crear el usuario administrador
            echo "<tr id=normal><td>$(date)</td>" >> $LOG
            echo "${ADMIN_USER}:${ADMIN_PASSWORD}" | chpasswd # Establecer la contraseña para el usuario administrador
            echo "<td>Contraseña de ${ADMIN_USER} establecida con éxito</td></tr>" >> $LOG
            echo "<tr id=normal><td>$(date)</td>" >> $LOG 
            passwd -l root # Bloquear la cuenta root 
            echo "<td>Usuario root bloqueado con éxito</td></tr>" >> $LOG
            return 0 # Usuario administrador creado con éxito
        fi
}