#!/bin/bash

set -e

genlogheader(){
    # Encabezado html
    echo -e "<!DOCTYPE html>
        <html lang="es">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="./logs.css">
            <title>$TITULO</title>
        </head>
        <body>" > $LOG
}

genlogsection(){
    # Sección html
    echo  -e "<h1>$TITULO_INFORME</h1>
         <table>
            <tr>
                <th>Fecha del log</th>
                <th>Descripción del log</th>
            </tr>" >> $LOG
}

genlogfinally(){
    # Final del html
    echo -e "</table> <br>
            <a href='/index.html'><input type='button' value='VOLVER'></a> 
            </body>
            </html>" >> $LOG
}