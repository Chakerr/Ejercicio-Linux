#!/bin/bash

# Verificar el estado de Apache2
if systemctl is-active --quiet apache2; then
    echo "Apache2 está activo y funcionando."
else
    echo "Apache2 no está activo. Iniciando Apache2..."
    sudo systemctl start apache2
    if systemctl is-active --quiet apache2; then
        echo "Apache2 se inició correctamente."
    else
        echo "Hubo un problema al intentar iniciar Apache2."
        exit 1
    fi
fi

# Definir variables
SYMLINK_PATH="/home/mario-palencia/QUIZ/A/B/E/config2.html"   # Archivo fuente
WEB_PATH="/var/www/html/config2.html"                        # Destino en Apache
INDEX_HTML_PATH="/var/www/html/index.html"                   # Archivo index de Apache

# Verificar si el enlace simbólico ya existe en el directorio de Apache
if [ ! -L "$WEB_PATH" ]; then
    echo "Creando el enlace simbólico en /var/www/html/"
    sudo ln -s "$SYMLINK_PATH" "$WEB_PATH"
else
    echo "El enlace simbólico ya existe en /var/www/html/"
fi

# Sobrescribir el contenido de index.html con config2.html
if [ -f "$SYMLINK_PATH" ]; then
    sudo cp "$SYMLINK_PATH" "$INDEX_HTML_PATH"
    echo "Contenido de $SYMLINK_PATH copiado correctamente a $INDEX_HTML_PATH"
else
    echo "El archivo $SYMLINK_PATH no existe o no es válido."
    exit 1
fi

# Recargar Apache2 para asegurar que los cambios sean visibles
sudo systemctl reload apache2

# Ruta del archivo local
archivo_local="/home/mario-palencia/QUIZ/A/B/E/config2.html"  # Añadido la barra inicial

# Dirección del servidor remoto (usuario@servidor)
servidor_remoto="mario@192.168.1.10"

# Ruta de destino en la máquina remota
ruta_remota="/home/mario"

# Definir la contraseña para sshpass
PASSWORD="mario08"

# Usar sshpass para enviar el archivo sin pedir contraseña
sshpass -p "$PASSWORD" scp "$archivo_local" "$servidor_remoto:$ruta_remota"

# Verifica si la transferencia fue exitosa
if [ $? -eq 0 ]; then
  echo "Archivo enviado con éxito."
  
  # Abre la página local en el navegador predeterminado
  xdg-open http://localhost
else
  echo "Hubo un error al enviar el archivo."
fi
