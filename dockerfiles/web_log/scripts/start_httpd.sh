#!/bin/bash
# Script de inicio del servicio HTTP

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS}/start.sh

# Traer funciones
source "${SCRIPTS}/genlogs.sh"

mainHTTP(){ # Función principal de configuración del servicio DNS
    echo "<tr id=normal><td>$(date)</td>" >> $LOG   
    echo '<td>Servicio HTTP configurado y ejecutado con éxito</td></tr>' >> $LOG    
    genlogfinally
    /usr/sbin/apache2ctl -D FOREGROUND # Ejecución del servicio
}

mainHTTP