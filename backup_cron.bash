#! /bin/bash

# Copyright <2022> <Strawberryai>
# Por la presente se concede permiso, libre de cargos, a cualquier persona que obtenga una copia 
# de este software y de los archivos de documentación asociados (el "Software"), a utilizar el 
# Software sin restricción, incluyendo sin limitación los derechos a usar, copiar, modificar, 
# fusionar, publicar, distribuir, sublicenciar, y/o vender copias del Software, y a permitir a 
# las personas a las que se les proporcione el Software a hacer lo mismo, sujeto a las siguientes 
# condiciones:
# 
# El aviso de copyright anterior y este aviso de permiso se incluirán en todas las copias o partes 
# sustanciales del Software.
# 
# EL SOFTWARE SE PROPORCIONA "COMO ESTÁ", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, INCLUYENDO 
# PERO NO LIMITADO A GARANTÍAS DE COMERCIALIZACIÓN, IDONEIDAD PARA UN PROPÓSITO PARTICULAR E 
# INCUMPLIMIENTO. EN NINGÚN CASO LOS AUTORES O PROPIETARIOS DE LOS DERECHOS DE AUTOR SERÁN RESPONSABLES 
# DE NINGUNA RECLAMACIÓN, DAÑOS U OTRAS RESPONSABILIDADES, YA SEA EN UNA ACCIÓN DE CONTRATO, AGRAVIO 
# O CUALQUIER OTRO MOTIVO, DERIVADAS DE, FUERA DE O EN CONEXIÓN CON EL SOFTWARE O SU USO U OTRO TIPO 
# DE ACCIONES EN EL SOFTWARE.
#
#
# Este es un script que se encarga de automatizar la creación de backups
# incrementales. Es ejecutado como una tarea de cron cada día a las 12 pm.
#
# Creamos una carpeta con la fecha actual y usamos la del día anterior como
# link-dest. En caso de que no exista copia del día anterior creamos la carpeta
# vacía.
#
# Instrucción cron (crontab -e): 
# 0 12 * * * bash /var/tmp/Backups/backup_cron.bash
#

BACKUP_DIR="/var/tmp/Backups/"
COPY_DIR="/home/ag6154lk/Seguridad/"

function get_previous_datename(){
    echo $(date --date="1 day ago" +%d-%m-%Y)
}

function get_current_datename(){
    echo $(date +%d-%m-%Y)
}

function make_backup(){
    prev="$BACKUP_DIR$(get_previous_datename)"
    curr="$BACKUP_DIR$(get_current_datename)"

    # Si no existe el directorio del backup anterior lo creamos
    [ ! -d "$prev" ] && mkdir $prev

    rsync -av --link-dest=$prev $COPY_DIR $curr
    # sudo rsync -av --compare-dest=$destino ./origen/ $copia_completa 
}

echo "Creating backup of "$COPY_DIR
make_backup
