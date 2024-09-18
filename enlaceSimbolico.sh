#!/bin/bash

# Ruta del archivo fuente
archivo_fuente=/home/chaker/Ejercicio-Linux/A/D/H/config2.html

# Ruta del enlace simbólico
enlace_simbolico=/home/chaker/Ejercicio-Linux/A/B/E/config2.html

# Crear el enlace simbólico
ln -s "$archivo_fuente" "$enlace_simbolico"

# Actualiza el arbol
/home/chaker/Ejercicio-Linux/pagina.sh
echo "HTML generado"

# Verificar si el enlace simbólico se creó correctamente
if [ -L "$enlace_simbolico" ]; then
  echo "Enlace simbólico creado exitosamente: $enlace_simbolico -> $archivo_fuente"
else
  echo "Error al crear el enlace simbólico."
	fi

