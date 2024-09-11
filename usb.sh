#!/bin/bash

usb_buscar="058f:6387"

# Usa `lsusb` en lugar de `susb` y corrige el espacio en el comando `grep`
if ! lsusb | grep -q "$usb_buscar"; then
    echo "La USB no se encuentra conectada"
else
    echo "La USB ha sido conectada"
    # Reemplaza esta línea con la acción deseada
    echo "Ejecutando la acción de conexión..."
    # Por ejemplo, podrías tener una función o comando específico aquí
    # lnc "$IP" 1234
fi



