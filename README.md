# Automatización de Procesos con Bash

Este proyecto consiste en la creación de varios scripts en Bash que automatizan la identificación de una unidad USB, la verificación de un código y la ejecución de diversas tareas, 
incluyendo la creación de una estructura de directorios, la generación de archivos de configuración, y la transferencia de datos entre dos servidores Apache.

## Descripción del Proceso

### 1. Identificación de la Unidad USB
El script debe:
- Detectar la conexión de una unidad USB.
- Verificar que dentro de la USB exista un código.
- Si el código encontrado en la USB coincide con el almacenado en el script, se ejecutarán las siguientes acciones.

### 2. Creación de la Estructura de Directorios
Si el código es válido, el script creará la siguiente estructura de directorios:

```plaintext

```

### 3. Creación de Archivos

#### 3.1. Archivo `config1` en la Carpeta G
En la carpeta `A/B/F/G`, se debe generar un archivo llamado `config1` que contenga la siguiente información del sistema:
- Memoria RAM
- Procesador
- Capacidad del disco duro
- Sistema operativo

#### 3.2. Archivo `config2.html` en la Carpeta H
En la carpeta `A/B/H`, se debe crear un archivo `config2.html` que contenga:
- Nombre del usuario, programa académico y la fecha actual.
- El árbol de directorios previamente creado.
- El contenido completo del archivo `config1`.

### 4. Creación de un Enlace Simbólico
En la carpeta `A/B/E`, se creará un enlace simbólico que apunte al archivo `config2.html` ubicado en `A/B/H`.

### 5. Encender un LED
Después de crear el archivo `config2.html`, el sistema encenderá un LED 5 veces como señal de confirmación del proceso.

### 6. Transferencia de Archivos entre Servidores Apache
Finalmente, el servidor `Apache 1` (cliente) enviará el enlace simbólico y la información generada al servidor `Apache 2`, utilizando `sshpass` con un usuario y contraseña. Una vez recibida la información, el servidor `Apache 2` abrirá automáticamente el archivo `config2.html`.

## Requisitos

### Software
- Bash
- Apache en ambos servidores
- `sshpass` para la transferencia de archivos vía SSH

### Hardware
- Unidad USB
- LED para confirmación visual

## Instrucciones de Uso

1. Conecta la unidad USB al sistema.
2. Ejecuta el script principal para detectar la USB y verificar el código.
3. Si el código es válido, el script creará automáticamente la estructura de directorios y generará los archivos `config1` y `config2.html`.
4. Verifica que el LED se encienda 5 veces, indicando que el proceso ha sido exitoso.
5. El servidor `Apache 1` transferirá el enlace simbólico a `Apache 2` mediante `sshpass`. El archivo `config2.html` se abrirá automáticamente en `Apache 2` para visualizar el contenido.

## Notas

- Asegúrate de tener permisos de superusuario para ejecutar las operaciones de creación de archivos y directorios.
- Verifica que los servidores Apache estén correctamente configurados y que `sshpass` esté instalado en ambos servidores.
- Los archivos `config1` y `config2.html` contendrán información sensible del sistema, por lo que deben ser protegidos adecuadamente.

## Contribuciones

Si deseas mejorar o contribuir a este proyecto, puedes crear una rama en el repositorio, realizar los cambios necesarios y enviar un pull request para su revisión.
