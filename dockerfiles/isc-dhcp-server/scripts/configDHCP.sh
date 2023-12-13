#!/bin/bash
# Script de configuración del servicio DHCP

set -e # Carga de las variables de entorno

configDHCP(){ # Función de configuración del servicio DHCP
    if [ ! -f /etc/default/isc-dhcp-server ]
    then
        echo "<tr id=error><td>$(date)</td>" >> $DHCP_LOG
        echo '<td>El archivo /etc/default/isc-dhcp-server no existe</td></tr>' >> $DHCP_LOG
        return 1 # Error inesperado
    else
        sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/g' /etc/default/isc-dhcp-server # Definir las interfaces que participan el servicio DHCP
    fi

    if [ $(grep -c dhcpd /etc/passwd) -eq 1 ]
    then
        echo "<tr id=error><td>$(date)</td>" >> $DHCP_LOG
        echo '<td>El usuario dhcpd existe</td></tr>' >> $DHCP_LOG
        return 1 # Error inesperado
    else
        echo "<tr id=normal><td>$(date)</td>" >> $DHCP_LOG
        useradd -r -s /usr/sbin/nologin -d /var/run dhcpd # Crear usuario dhcpd
        echo '<td>Usuario del servicio dhcp creado con éxito</td></tr>' >> $DHCP_LOG
    fi

    if [ ! -f /var/lib/dhcp/dhcpd.leases ] # Comprobar que existen los archivos de las concesiones
    then
        # Crear los archivos de las concesiones
        echo "<tr id=normal><td>$(date)</td>" >> $DHCP_LOG
        touch /var/lib/dhcp/dhcpd.leases
        touch /var/lib/dhcp/dhcpd.leases~
        echo '<td>Archivos de concesiones creados con éxito</td></tr>' >> $DHCP_LOG
    else
        echo "<tr id=normal><td>$(date)</td><td>" >> $DHCP_LOG
        chown -v dhcpd:dhcpd /var/lib/dhcp -R >> $DHCP_LOG # Otorgar la propiedad de los archivos al usuario dhcpd
        echo '</td></tr>' >> $DHCP_LOG
        return 0
    fi
}