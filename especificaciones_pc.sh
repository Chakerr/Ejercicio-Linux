#!/bin/bash

# Eliminar y crear directorios
rm -rf /home/chaker/Ejercicio-Linux/A
mkdir -p /home/chaker/Ejercicio-Linux/A
mkdir -p /home/chaker/Ejercicio-Linux/A/B /home/chaker/Ejercicio-Linux/A/C /home/chaker/Ejercicio-Linux/A/D
mkdir -p /home/chaker/Ejercicio-Linux/A/B/E /home/chaker/Ejercicio-Linux/A/B/F /home/chaker/Ejercicio-Linux/A/B/G
mkdir -p /home/chaker/Ejercicio-Linux/A/D/H


# Archivos de salida
archivo_salida="/home/chaker/Ejercicio-Linux/A/B/G/config1.txt"
archivo_html="/home/chaker/Ejercicio-Linux/A/D/H/config2.html"

# Eliminar archivo de salida si existe
if [ -f "$archivo_salida" ]; then
	rm "$archivo_salida"
fi

# Obtener la información del sistema
ram_total=$(grep MemTotal /proc/meminfo | awk '{print $2/1024 " MB"}')
procesador=$(grep -m 1 'model name' /proc/cpuinfo | awk -F: '{print $2}')
disco_total=$(df --total --output=size | tail -n 1 | awk '{print $1/1024 " MB"}')
sistema_operativo=$(lsb_release -d | awk -F"\t" '{print $2}')
version_kernel=$(uname -r)
fecha=$(date +"%d/%m/%Y")
hora=$(date +"%H:%M")

# Escribir la información en el archivo de salida
echo "Información del sistema" > "$archivo_salida"
echo "=======================" >> "$archivo_salida"
echo "RAM Total: $ram_total" >> "$archivo_salida"
echo "Procesador: $procesador" >> "$archivo_salida"
echo "Capacidad total del Disco Duro: $disco_total" >> "$archivo_salida"
echo "Sistema Operativo: $sistema_operativo" >> "$archivo_salida"
echo "Versión del kernel: $version_kernel" >> "$archivo_salida"
echo "Fecha: $fecha" >> "$archivo_salida"
echo "Hora: $hora" >> "$archivo_salida"

echo "El archivo $archivo_salida ha sido creado con éxito."

# Texto a leer en voz alta
texto_a_leer="La computadora posee un procesador $procesador, una memoria RAM de $ram_total, 
su disco duro tiene una capacidad total de $disco_total. Esta información fue suministrada el 
día $fecha a las $hora."

# Leer la información en voz alta
espeak -a 400 -v es -s140 -p 50 "$texto_a_leer" --stdout | aplay

# Verificación de argumentos para el script de conversión
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 archivo.txt archivo.html"
    exit 1
fi

# Archivo txt a html
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
