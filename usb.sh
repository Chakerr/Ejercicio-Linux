#!/bin/bash

usb_buscar="0951:1665"
usb_mount_point="/media/mario-palencia/E880-B11C"
search_file="inicio.txt"
numero_buscar="023"

buscar_archivo() {
    if [ -f "$usb_mount_point/$search_file" ]; then
        echo "Archivo $search_file encontrado en el dispositivo USB."
        
        if grep -q "$numero_buscar" "$usb_mount_point/$search_file"; then
            echo "El número $numero_buscar fue encontrado en el archivo."
            return 0 
        else
            echo "El número $numero_buscar NO fue encontrado en el archivo."
            return 1 
        fi
    else
        echo "Archivo $search_file no encontrado en el dispositivo USB."
        return 1
    fi
}

while true; do
    if lsusb | grep -q "$usb_buscar"; then
        echo "La USB ha sido conectada"
        echo "Ejecutando la acción de conexión..."

        while true; do
            buscar_archivo
            if [ $? -eq 0 ]; then
                echo "Proceso terminado: archivo y número encontrados."
                ./rama.sh  
                break  
            fi
            sleep 2  
        done

        break  
    else
        echo "La USB no se encuentra conectada"
    fi
    sleep 2
done


