#!/bin/bash

# Ruta del archivo fuente
archivo_fuente=/Ruta_al_archivo

# Ruta del enlace simbólico
enlace_simbolico=/Ruta_donde_se_guarda_el_enlace

# Crear el enlace simbólico
ln -s "$archivo_fuente" "$enlace_simbolico"

# Verificar si el enlace simbólico se creó correctamente
if [ -L "$enlace_simbolico" ]; then
  echo "Enlace simbólico creado exitosamente: $enlace_simbolico -> $archivo_fuente"
else
  echo "Error al crear el enlace simbólico."
	fi

