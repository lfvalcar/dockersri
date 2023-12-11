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
            <title>$1</title>
        </head>
        <body>" > $2
}

genlogsection(){
    # Sección html
    echo  -e "<h1>$1</h1>
         <table>
            <tr>
                <th>Fecha del log</th>
                <th>Descripción del log</th>
            </tr>" >> $2
}

genlogfinally(){
    # Final del html
    echo -e "</table> <br>
            <a href='/index.html'><input type='button' value='VOLVER'></a> 
            </body>
            </html>" >> $1
}