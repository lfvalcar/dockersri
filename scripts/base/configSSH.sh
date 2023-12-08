#!/bin/bash
# Script de configuración del servicio SSH en la imagen base

set -e # Carga de las variables de entorno

configSSH(){ # Función de configuración del servicio SSH
    if [ ! -f /etc/ssh/sshd_config ] # Comprobar si existe el archivo de confguración del servicio SSH
    then
        echo 'El archivo /etc/ssh/sshd_config no existe'
        return 1 # Error inesperado
    else 
        sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config # Denegar la conexión de ssh a root
        sed -i "s/#Port 22/Port ${SSH_PORT}/g" /etc/ssh/sshd_config # Establecer puerto distinto para la conexión SSH
        
        if [ ! -d /var/run/sshd ] # Comprobar si existe el directorio /var/run/sshd
        then
            mkdir /var/run/sshd # Creamos el directorio para le demonio en ejecución del servicio SSH
        fi

        if [ ! -d "/home/${ADMIN_USER}/.ssh" ] # Comporbar si existe el directorio .ssh en el home del usuario administrador para depositar la clave rsa
        then
            mkdir /home/${ADMIN_USER}/.ssh # Crear el directorio .ssh en el usuario administrador
        fi

        cat /root/id_rsa.pub >> /home/${ADMIN_USER}/.ssh/authorized_keys # Añadir la clave rsa al home del usuario administrador

        /usr/sbin/sshd -D & # Ejecución del servicio SSH en segundo plano

        return 0 # Servicio SSH configurado con éxito
    fi
}