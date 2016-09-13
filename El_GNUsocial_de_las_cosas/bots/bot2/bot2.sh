#!/bin/bash
# bot2. Ejemplo de bot cotilla que estará pendiente de lo que diga alguien.
# email: fanta <fantanaranja@openmailbox.org>
# jid: fanta@xmpp.linuxinthenight.com
# Se necesita tener instalado xmlstarlet. En debian: apt-get install xmlstarlet
# Se necesita tener instalado tweeper. En debian: apt-get install tweeper

echo "" > lt.txt 				# Puesta a 0 de los últimos tweets
tr=60						# tiempo en refrescar para comprobar si existen nuevos tweets
ct="https://twitter.com/EsperanzAguirre"	# cuenta twitter de la que extraer mierda
us=prueba 					# el nombre de la cuenta. Usuario
pw=123456					# La contraseña.
no=gnusocial.net				# Nodo.
pt=https					# https o http

while :
do
	# sacamos el tweet más fresco
	lt=$(tweeper $ct | xmlstarlet sel -T -t -v "rss/channel/item/title" - | cut -d ":" -f 2 | cut -d " " -f 2-999 | sed '/^$/d' | head -1) # El último tweet
	# comprobamos que no sea igual al último que se sacó
	lt2=$(cat lt.txt) # último tweet que se sacó en el pasado

	if [ "$lt" = "$lt2" ]
        then
		echo "Sin novedad en el frente."
	else
		#  publicamos mierda
		curl -u $us:$pw -d status="$lt" $pt://$no/api/statuses/update.xml
	fi
	sleep $tr
	echo "$lt" > lt.txt
done
