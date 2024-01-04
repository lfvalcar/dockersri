#!/bin/bash
# Script de configuración del servicio SSH en la imagen base

set -e # Carga de las variables de entorno

configSSH(){ # Función de configuración del servicio SSH
    if [ ! -f /etc/ssh/sshd_config ] # Comprobar si existe el archivo de confguración del servicio SSH
    then
        echo "<tr id=error><td>$(date)</td>" >> $LOG
        echo '<td>El archivo /etc/ssh/sshd_config no existe</td></tr>'
        return 1 # Error inesperado
    else 
        sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config # Denegar la conexión de ssh a root
        sed -i "s/#Port 22/Port ${SSH_PORT}/g" /etc/ssh/sshd_config # Establecer puerto distinto para la conexión SSH
        sed -i 's/#LoginGraceTime 2m/LoginGraceTime 5m/g' /etc/ssh/sshd_config # En caso de bloqueo, un tiempo de espera de 5m para volver
        sed -i 's/#MaxSessions 10/MaxSessions 3/g' /etc/ssh/sshd_config # Un máximo de 3 conexiones activas ssh
        sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/g' /etc/ssh/sshd_config # Un máximo de 3 intentos fallidos de autenticación
        sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config # Se permite la autenticación mediante clave pública
        sed -i 's/#   PasswordAuthentication yes/    PasswordAuthentication no/g' /etc/ssh/ssh_config # Se deniega la autenticación mediante contraseña
        
        if [ ! -d /var/run/sshd ] # Comprobar si existe el directorio /var/run/sshd
        then
            echo "<tr id=normal><td>$(date)</td>" >> $LOG
            echo '<td>' >> $LOG
            mkdir -v /var/run/sshd >> $LOG # Creamos el directorio para le demonio en ejecución del servicio SSH
            echo '</td></tr>' >> $LOG
        fi

        if [ ! -d "/home/${ADMIN_USER}/.ssh" ] # Comporbar si existe el directorio .ssh en el home del usuario administrador para depositar la clave rsa
        then
            if [ ! -d "/home/${ADMIN_USER}" ]
            then
                echo "<tr id=error><td>$(date)</td>" >> $LOG
                echo "<td>No existe el home del usuario ${ADMIN_USER}</td></tr>" >> $LOG # Crear el directorio .ssh en el usuario administrador
                return 1
            fi 
            echo "<tr id=normal><td>$(date)</td>" >> $LOG
            echo '<td>' >> $LOG
            mkdir -v /home/${ADMIN_USER}/.ssh >> $LOG # Crear el directorio .ssh en el usuario administrador
            echo '</td></tr>' >> $LOG
        fi

        cat /root/id_rsa.pub >> /home/${ADMIN_USER}/.ssh/authorized_keys # Añadir la clave rsa al home del usuario administrador
        return 0 # Servicio SSH configurado con éxito
    fi
}