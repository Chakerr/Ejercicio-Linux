{
  echo "Subject: Ejercicio Linux"
  echo "Mi nombre es chaker"
} | msmtp -a gmail Correo@gmail.com

if [ $? -eq 0 ]; then
  echo "Mensaje enviado con éxito"
else
  echo "Error al enviar el mensaje"
fi
