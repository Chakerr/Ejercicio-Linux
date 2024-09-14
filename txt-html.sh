#!/bin/bash

# Verifica que se proporcionaron dos argumentos
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 archivo.txt archivo.html"
    exit 1
fi

txt_file="$1"
html_file="$2"

# Comprueba si el archivo de texto existe
if [ ! -f "$txt_file" ]; then
    echo "El archivo de texto '$txt_file' no existe."
    exit 1
fi

# Crear el archivo HTML
{
    echo "<!DOCTYPE html>"
    echo "<html>"
    echo "<head>"
    echo "    <title>Documento convertido</title>"
    echo "    <meta charset=\"UTF-8\">"
    echo "</head>"
    echo "<body>"
    echo "    <pre>"
    cat "$txt_file"
    echo "    </pre>"
    echo "</body>"
    echo "</html>"
} > "$html_file"

echo "Conversión completada: $html_file"
