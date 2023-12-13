#!/bin/bash
# Script de inicio del servicio HTTP

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS}/start.sh

# Traer funciones
source "${SCRIPTS}/genlogs.sh"

mainHTTP(){ # Función principal de configuración del servicio DNS
    genlogsection
    
    echo "<tr id=normal><td>$(date)</td>" >> $LOG   
    echo '<td>Servicio HTTP configurado y ejecutado con éxito</td></tr></table>' >> $LOG    
    genlogfinally $LOG
    /usr/sbin/apache2ctl -D FOREGROUND # Ejecución del servicio
}

mainHTTP