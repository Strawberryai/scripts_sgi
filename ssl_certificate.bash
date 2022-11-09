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
# ssh-keygen -t ed25519 -C "your_email@example.com"
#

DOMAIN="muffin"

function requisitos_previos(){
    sudo apt update
    sudo apt install apache2
    
    # Abrir los puertos http y https del firewall
    sudo ufw allow "Apache Full" 
}

function habilitar_modssl(){
    # Para poder emplear certificados ssl con apache hay que habilitar un
    # módulo que nos lo permita
    sudo a2enmod ssl
    sudo systemctl restart apache

}

function crear_certificadoSSL(){
    # Crearmos un nuevo certificado autofirmado en /etc/ssl/certs llamado
    # apache-selfsigned.crt
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
}

function configurar_apacheSSL(){
    sudo echo "
<VirtualHost *:443>
   ServerName your_domain_or_ip
   DocumentRoot /var/www/your_domain_or_ip

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
<VirtualHost *:80>
	ServerName your_domain_or_ip
	Redirect / https://your_domain_or_ip/
</VirtualHost>" >> /etc/apache2/sites-available/$DOMAIN.conf

    # sudo nano /var/www/your_domain_or_ip/index.html
    #habilitar el archivo de configuracion de apache
    sudo a2ensite $DOMAIN.conf 
    sudo apache2ctl configtest
    sudo systemctl reload apache2
}

