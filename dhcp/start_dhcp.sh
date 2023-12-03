#!/bin/bash
# Script de inicio del servicio DHCP

set -eu # Seguimiento de errores de las variables y carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash /root/start.sh
# Traer funciones
source /root/scriptsDHCP/configDHCP.sh