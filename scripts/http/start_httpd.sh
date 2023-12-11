#!/bin/bash
# Script de inicio del servicio HTTP

set -e # Carga de las variables de entorno

# Iniciamos el script de inicio de la imagen base
bash ${SCRIPTS_BASE}/start.sh 'LOG LOGSSRV' 'INFORME DEL CONTENEDOR LOGSSRV' $HTTP_LOG

# Traer funciones
source "${SCRIPTS_GEN_LOGS}/genlogs.sh"

mainHTTP(){ # Función principal de configuración del servicio DNS
    genlogsection "$1" $HTTP_LOG
    
    echo "<tr id=normal><td>$(date)</td>" >> $HTTP_LOG   
    echo '<td>Servicio HTTP configurado y ejecutado con éxito</td></tr></table>' >> $HTTP_LOG    
    genlogfinally $HTTP_LOG
    /usr/sbin/apache2ctl -D FOREGROUND # Ejecución del servicio
}

mainHTTP 'INFORME DEL CONTENEDOR LOGSSRV'