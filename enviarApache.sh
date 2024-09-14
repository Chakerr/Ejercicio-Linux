#!/bin/bash

# Datos de la conexión SSH
USUARIO="Usuario"
IP="100.100.100.100"
PASSWORD="contraseña"
ORIGEN="/home/"
DESTINO="/home/"

# Verificar que el enlace simbólico exista localmente
if [ -L "$ORIGEN" ]; then
    echo "El enlace simbólico local $ORIGEN existe, procediendo con la transferencia..."
else
    echo "Error: El enlace simbólico local $ORIGEN no existe."
    exit 1
fi

# Usar rsync para copiar el enlace simbólico al servidor remoto
sshpass -p "$PASSWORD" rsync -avz -e "ssh -o StrictHostKeyChecking=no" --links "$ORIGEN" "$USUARIO@$IP:$DESTINO"

# Verificar si la transferencia fue exitosa
if [ $? -eq 0 ]; then
    echo "Enlace simbólico copiado exitosamente a $IP"
else
    echo "Error al copiar el enlace simbólico a $IP"
    exit 1
fi


