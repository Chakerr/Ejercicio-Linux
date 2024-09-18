#!/bin/bash
# Encender el LED de la tecla mayús del teclado.

led="/sys/class/leds/input3::capslock/"

if [ -d "$led" ]; then
  for i in {1..5}; do
    echo 1 | sudo tee "${led}/brightness" >/dev/null
    sleep 0.5
    echo 0 | sudo tee "${led}/brightness" >/dev/null
    sleep 0.5
  done
  echo "LED CAPS LOCK COMPLETADO"
else
  echo "RUTA DEL LED NO ENCONTRADA"
fi

