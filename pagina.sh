#!/bin/bash

# Datos
name="Luis"
degree="Ingeniero"
date_today=$(date +"%d/%m/%Y")
directory_path="$(pwd)"  # Directorio actual donde se ejecuta el script

# Especifica la ruta donde se creará el HTML
output_directory="/home/chaker/Documentos/Ejercicio-Linux-main/A/D/H"
output_file="$output_directory/config2.html"

# Crea el directorio si no existe
mkdir -p "$output_directory"

config_file="$directory_path/A/B/G/config1.txt"

if [ -f "$config_file" ]; then
	config_content=$(cat "$config_file")
else 
	config_content="El archivo de configuración no existe."
fi

directory_tree=$(tree "/home/chaker/Documentos/Ejercicio-Linux-main/")

# Crear el documento HTML en la carpeta especificada
cat <<EOF > "$output_file"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Documento de Información</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        pre {
            background-color: #f4f4f4;
            padding: 10px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <h1>Información Personal</h1>
    <p>Nombre: $name</p>
    <p>Título: $degree</p>
    <p>Fecha: $date_today</p>
    <h2>Árbol de Directorios</h2>
    <pre>$directory_tree</pre>
    <h2>Contenido del Archivo de configuración config1</h2>
    <pre>$config_content</pre>
</body>
</html>
EOF

echo "El archivo HTML ha sido creado exitosamente en $output_directory."