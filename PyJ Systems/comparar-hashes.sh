#!/bin/bash

# Definir los hashes proporcionados
declare -A hashes=(
  ["copia.sh"]="90965b0eb20e68b7d0b59accd2a3b4fd"
  ["log.txt"]="0b29406e348cd5f17c2fd7b47b1012f9"
  ["pass.txt"]="6d5e43a730490d75968279b6adbd79ec"
  ["plan-A.txt"]="129ea0c67567301df1e1088c9069b946"
  ["plan-B.txt"]="4e9878b1c28daf4305f17af5537f062a"
  ["script.py"]="66bb9ec43660194bc066bd8b4d35b151"
)

# Función para calcular el hash MD5 de un archivo
calcular_hash() {
  md5sum "$1" | cut -d ' ' -f 1
}

# Comparar hashes

mensaje_modificacion=""
modificacion_detectada=false

for archivo in "${!hashes[@]}"; do
  hash_esperado="${hashes[$archivo]}"
  hash_calculado=$(calcular_hash "$archivo")

  if [ "$hash_calculado" == "$hash_esperado" ]; then
    echo "$archivo: Hash no alterado"
  else
    echo "$archivo: Se han encotnrado alteraciones en el MD5 de este archivo"
    mensaje_modificacion="Tras el análisis, se ha detectado que se ha modificado el archivo $archivo"
    modificacion_detectada=true

  fi

done

#Resultados de la comparacion de hashes

if [ "$modificacion_detectada" = true ]; then
  echo "$mensaje_modificacion"
else
  echo "No se han detectado archivos modificados"
fi
