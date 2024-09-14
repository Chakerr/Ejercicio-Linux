#!/bin/bash

# Ruta de tu archivo HTML (cambia esta ruta según sea necesario)
ARCHIVO_HTML="/home/chaker/config2.html"

# Verificar si el archivo HTML existe
if [ ! -f "$ARCHIVO_HTML" ]; then
  echo "Error: El archivo HTML no existe en la ruta especificada."
  exit 1
fi

# Actualizar e instalar Apache2 si no está instalado
echo "Instalando Apache2..."
sudo apt update
sudo apt install -y apache2

# Verificar si la instalación fue exitosa
if [ $? -ne 0 ]; then
  echo "Error: No se pudo instalar Apache2."
  exit 1
fi

# Definir el directorio de Apache2 donde se deben copiar los archivos HTML
WEB_DIR="/var/www/html"

# Copiar el archivo HTML al directorio de Apache
echo "Copiando archivo HTML al directorio $WEB_DIR..."
sudo cp "$ARCHIVO_HTML" "$WEB_DIR/index.html"

# Dar permisos adecuados
echo "Estableciendo permisos..."
sudo chmod 755 "$WEB_DIR/index.html"

# Iniciar y habilitar Apache2
echo "Iniciando el servicio Apache2..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Verificar el estado de Apache2
echo "Verificando el estado de Apache2..."
sudo systemctl status apache2

# Mostrar mensaje de acceso
IP=$(hostname -I | awk '{print $1}')
echo "La página web está lista. Accede desde: http://localhost o http://$IP"

exit 0
