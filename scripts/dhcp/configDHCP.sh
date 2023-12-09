#!/bin/bash
# Script de configuración del servicio DHCP

set -e # Carga de las variables de entorno

configDHCP(){ # Función de configuración del servicio DHCP
    sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/g' /etc/default/isc-dhcp-server # Definir las interfaces que participan el servicio DHCP
    useradd -r -s /usr/sbin/nologin -d /var/run dhcpd
    chown dhcpd:dhcpd /var/lib/dhcp -R
}