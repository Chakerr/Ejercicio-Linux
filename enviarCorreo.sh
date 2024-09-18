{
  echo "Subject: Quiz Linux"
  echo "Mi nombre es luis gabriel romero castro y mi nota del quiz es 5.0"
} | msmtp -a gmail luisgabrielromerocastro789@gmail.com

if [ $? -eq 0 ]; then
  echo "Mensaje enviado con éxito"
else
  echo "Error al enviar el mensaje"
fi
