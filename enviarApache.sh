#!/bin/bash

# Verificar y asegurar que Apache2 está activo localmente
if ! systemctl is-active --quiet apache2; then
    echo "Apache2 no está activo. Iniciando Apache2..."
    sudo systemctl start apache2
    if ! systemctl is-active --quiet apache2; then
        echo "Hubo un problema al intentar iniciar Apache2 en la máquina local."
        exit 1
    fi
    echo "Apache2 se inició correctamente en la máquina local."
else
    echo "Apache2 está activo y funcionando en la máquina local."
fi

# Definir variables
archivoFuente="/home/chaker/QUIZ/A/B/E/config2.html"  # Archivo fuente local
apache="/var/www/html/config2.html"                           # Destino en Apache local
index="/var/www/html/index.html"                              # Archivo index de Apache local
servidor_remoto="mario-palencia@192.168.244.129"                          # Dirección del servidor remoto
ruta_remota="/home/mario-palencia/config2.html"                        # Ruta completa del archivo en la máquina remota
PASSWORD="Mario2004"                                          # Contraseña para sshpass

# Verificar y crear el enlace simbólico si no existe en la máquina local
if [ ! -L "$apache" ]; then
    echo "Creando el enlace simbólico en /var/www/html/"
    sudo ln -s "$archivoFuente" "$apache"
else
    echo "El enlace simbólico ya existe en /var/www/html/"
fi

# Copiar el contenido de config2.html a index.html en la máquina local
if [ -f "$archivoFuente" ]; then
    sudo cp "$archivoFuente" "$index"
    echo "Contenido de $archivoFuente copiado correctamente a $index en la máquina local."
else
    echo "El archivo $archivoFuente no existe o no es válido en la máquina local."
    exit 1
fi

# Recargar Apache2 en la máquina local
sudo systemctl reload apache2

# Transferir el archivo a la máquina remota usando sshpass
if sshpass -p "$PASSWORD" scp "$archivoFuente" "$servidor_remoto:$ruta_remota"; then
    echo "Archivo enviado con éxito a la máquina remota."
    
    # Verificar si Apache2 está activo en la máquina remota
    if sshpass -p "$PASSWORD" ssh "$servidor_remoto" "systemctl is-active --quiet apache2"; then
        echo "Apache2 está activo en la máquina remota."
    else
        echo "Apache2 no está activo en la máquina remota. Iniciándolo..."
        sshpass -p "$PASSWORD" ssh "$servidor_remoto" "sudo systemctl start apache2"
        if sshpass -p "$PASSWORD" ssh "$servidor_remoto" "systemctl is-active --quiet apache2"; then
            echo "Apache2 se inició correctamente en la máquina remota."
        else
            echo "No se pudo iniciar Apache2 en la máquina remota."
            exit 1
        fi
    fi
    
    # Copiar el contenido de config2.html a index.html en la máquina remota sin pedir contraseña
    sshpass -p "$PASSWORD" ssh "$servidor_remoto" "sudo cp $ruta_remota /var/www/html/index.html && sudo systemctl reload apache2"
    echo "Contenido de config2.html copiado correctamente a index.html en la máquina remota."

else
    echo "Hubo un error al enviar el archivo a la máquina remota."
    exit 1
fi

# Abrir la página web en el navegador de la máquina local
xdg-open "http://192.168.244.129"
echo "Página web abierta en la máquina local."
