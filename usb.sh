#!/bin/bash

usb_buscar="058f:6387"
usb_mount_point="/media/chaker/LUIS/inicio.txt"
numero_buscar="024"

# Función para buscar archivo y número en el archivo
buscar_archivo() {
    if [ -f "$usb_mount_point" ]; then
        echo "Archivo encontrado en el dispositivo USB."

        if grep -q "$numero_buscar" "$usb_mount_point"; then
            echo "El número $numero_buscar fue encontrado en el archivo."
            return 0
        else
            echo "El número $numero_buscar NO fue encontrado en el archivo."
            return 1
        fi
    else
        echo "Archivo no encontrado en el dispositivo USB."
        return 1
    fi
}

# Función para obtener el puerto USB
obtener_puerto_usb() {
    
    bus_device=$(lsusb | grep "$usb_buscar" | awk '{print $2"/"$4}' | sed 's/://')

    if [ -n "$bus_device" ]; then
        echo "El puerto es: /dev/bus/usb/$bus_device"
        udevadm info --name=/dev/bus/usb/$bus_device | grep "DEVPATH"
    else
        echo "No se pudo encontrar el puerto del dispositivo USB."
    fi
}

usb_conectado=false

# Bucle principal para monitorear la conexión USB
while true; do
    if lsusb | grep -q "$usb_buscar"; then
        if ! $usb_conectado; then
            echo "La USB ha sido conectada"
            usb_conectado=true

            # Mostrar puerto USB
            obtener_puerto_usb

            sleep 5  
        fi

        sleep 2
        
        buscar_archivo
        if [ $? -eq 0 ]; then
            echo "Proceso terminado: archivo y número encontrados."
            /home/chaker/QUIZ/especificaciones_pc.sh
            /home/chaker/QUIZ/pagina.sh
            /home/chaker/QUIZ/enlaceSimbolico.sh
            /home/chaker/QUIZ/enviarApache.sh
            /home/chaker/QUIZ/encenderLedMayus.sh
            /home/chaker/QUIZ/enviarCorreo.sh
            break
        else
            echo "Finalizando bucle: archivo o número no encontrados."
            break
        fi
    else
        if $usb_conectado; then
            echo "La USB no se encuentra conectada"
            usb_conectado=false
        fi
    fi
    sleep 5  
done
