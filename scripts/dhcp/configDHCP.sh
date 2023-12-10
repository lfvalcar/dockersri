#!/bin/bash
# Script de configuración del servicio DHCP

set -e # Carga de las variables de entorno

configDHCP(){ # Función de configuración del servicio DHCP
    sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/g' /etc/default/isc-dhcp-server # Definir las interfaces que participan el servicio DHCP
    
    if [ $(grep -c dhcpd /etc/passwd) -eq 1 ]
    then 
        echo 'El usuario dhcpd existe'
        return 1 # Error inesperado
    else
        useradd -r -s /usr/sbin/nologin -d /var/run dhcpd # Crear usuario dhcpd
    fi

    if [ ! -f /var/lib/dhcp/dhcpd.leases ] # Comprobar que existen los archivos de las concesiones
    then
        # Crear los archivos de las concesiones
        touch /var/lib/dhcp/dhcpd.leases
        touch /var/lib/dhcp/dhcpd.leases~
    else
        chown dhcpd:dhcpd /var/lib/dhcp -R # Otorgar la propiedad de los archivos al usuario dhcpd
        return 0
    fi
}