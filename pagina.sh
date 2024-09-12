#!/bin/bash

# Datos
name="NOMBRE :D"
degree="Ingeniería de Sistemas"
date_today=$(date +"%d/%m/%Y")
directory_path="$(pwd)"  # Directorio actual donde se ejecuta el script

# Generar el árbol de directorios
directory_tree=$(tree "$directory_path")

# Crear el documento HTML
cat <<EOF > documento.html
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
</body>
</html>
EOF

echo "El archivo HTML ha sido creado exitosamente."

