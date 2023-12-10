#!/bin/bash
# Script de configuración del servicio SSH en la imagen base

set -e # Carga de las variables de entorno

configSSH(){ # Función de configuración del servicio SSH
    if [ ! -f /etc/ssh/sshd_config ] # Comprobar si existe el archivo de confguración del servicio SSH
    then
        echo "<tr id=error><td>$(date)</td>" >> $1
        echo '<td>El archivo /etc/ssh/sshd_config no existe</td></tr>'
        return 1 # Error inesperado
    else 
        sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config # Denegar la conexión de ssh a root
        sed -i "s/#Port 22/Port ${SSH_PORT}/g" /etc/ssh/sshd_config # Establecer puerto distinto para la conexión SSH
        
        if [ ! -d /var/run/sshd ] # Comprobar si existe el directorio /var/run/sshd
        then
            echo "<tr id=normal><td>$(date)</td>" >> $1
            echo '<td>' >> $1
            mkdir -v /var/run/sshd >> $1 # Creamos el directorio para le demonio en ejecución del servicio SSH
            echo '</td></tr>' >> $1
        fi

        if [ ! -d "/home/${ADMIN_USER}/.ssh" ] # Comporbar si existe el directorio .ssh en el home del usuario administrador para depositar la clave rsa
        then
            echo "<tr id=normal><td>$(date)</td>" >> $1
            echo '<td>' >> $1
            mkdir -v /home/${ADMIN_USER}/.ssh >> $1 # Crear el directorio .ssh en el usuario administrador
            echo '</td></tr>' >> $1
        fi

        cat /root/id_rsa.pub >> /home/${ADMIN_USER}/.ssh/authorized_keys # Añadir la clave rsa al home del usuario administrador
        return 0 # Servicio SSH configurado con éxito
    fi
}