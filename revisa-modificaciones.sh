#!/bin/bash

# Ruta donde se buscarán los archivos
ruta="/html/"

# Nombre del archivo CSV de salida
archivo_csv="archivos_modificados_hoy.csv"

# Buscar archivos modificados el día de hoy con las extensiones dadas y guardarlos en el archivo CSV
find "$ruta" -type f \( -name "*.php" -o -name "*.pl" -o -name "*.py" -o -name "*.js" -o -name "*.css" -o -name "*.html" \) -daystart -mtime 0 -print0 | while IFS= read -r -d $'\0' archivo; do
    fecha_modificacion=$(stat -c '%y' "$archivo")
    usuario_modificacion=$(stat -c '%U' "$archivo")
    ruta_archivo=$(realpath "$archivo")
    nombre_archivo=$(basename "$archivo")
    echo "$fecha_modificacion,$nombre_archivo,$usuario_modificacion,$ruta_archivo" >> "$archivo_csv"
done



echo "Búsqueda completada. Resultados guardados en $archivo_csv"