#!/bin/bash

rm -rf A
mkdir -p A
mkdir -p A/B A/C A/D
mkdir -p A/B/E A/B/F A/B/G
mkdir -p A/D/H


archivo_salida="A/B/G/config1.txt"

if [ -f "$archivo_salida" ]; then
	rm "$archivo_salida"
fi

#Obtener la informacion de la RAM
ram_total=$(grep MemTotal /proc/meminfo | awk '{print $2/1024 " MB"}')

#Obtener la informacion del procesador
procesador=$(grep -m 1 'model name' /proc/cpuinfo | awk -F: '{print $2}')

#Obtener informacion del disco duro
disco_total=$(df --total --output=size | tail -n 1 | awk '{print $1/1024 " MB"}')

#Obtener informacion del sistema operativo
sistema_operativo=$(lsb_release -d | awk -F"\t" '{print $2}')

version_kernel=$(uname -r)

fecha=$(date +"%d/%m/%Y")
hora=$(date +"%H:%M")

#Escribir la información en el archivo salida
echo "Información del sistema" > "$archivo_salida"
echo "=======================" >> "$archivo_salida"
echo "RAM Total: $ram_total" >> "$archivo_salida"
echo "Procesador: $procesador" >> "$archivo_salida"
echo "Capacidad total del Disco Duro: $disco_total" >> "$archivo_salida"
echo "Sistema Operativo: $sistema_operativo" >> "$archivo_salida"
echo "Versión del kernel: $version_kernel" >> "$archivo_salida"
echo "Fecha: $fecha" >> "$archivo_salida"
echo "Hora: $hora" >> "$archivo_salida"

echo "El archivo $archivo_salida ha sido creado con exito."

texto_a_leer="La computadora tiene un procesador $procesador, una memoria RAM de $ram_total, su disco duro tiene una capacidad total de $disco_total. Esta información fue dada el día $fecha a las $hora."

espeak -a 400 -v es -s140 -p 50 "$texto_a_leer" --stdout | aplay
