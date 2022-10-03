# Alan García Justel
#
# Este es un script para encontrar la imagen que contiene el mensaje oculto
# haciendo uso de la herramienta Stegosuite.
#
# Comando: stegosuite -x "path" -> Extrae el mensaje embebido en la imagen
#

import argparse
import subprocess
import hashlib
from os import listdir
from os.path import isfile, join, splitext

# Formato de los archivos
FILE_FORMAT = ".jpg"

# Hash a buscar
HASH = "e5ed313192776744b9b93b1320b5e268"

def es_hash(filepath):
    encontrado = False

    with open(filepath, 'rb') as f:
        md5 = hashlib.md5(f.read())
        myhash = md5.hexdigest()
        if myhash == HASH:
            encontrado = True

    return encontrado

def main(path):
    print("Hello world")

    files = [f for f in listdir(path) if isfile(join(path, f)) and splitext(f)[1] == FILE_FORMAT]
    #files = [f for f in listdir(path) if isfile(join(path, f))]

    fileHash = ""
    encontrado = False
    for f in files:
        encontrado = es_hash(join(path, f))

        if(encontrado):
            fieHash = f
            print(f"Se ha encontrado el archivo correspondiente al hash dado. Archivo: {f}")
            break

    # Lo ideal sería leer el mensaje oculto con un subproceso de Stegosuite,
    # pero salta una excepción de Java al intentar ejecutarlo :( 


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Encontrar mensaje escondido')
    parser.add_argument('path', help='path of the folder containing the images')
    args = parser.parse_args()

    main(args.path)
