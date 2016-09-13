#!/bin/bash
# bot1. Ejemplo de bot que manda frases a gnusocial cada x tiempo
# http://mierda.linuxinthenight.com/shit/100frases.txt <-- 100frases.txt de ejemplo
# email: fanta <fantanaranja@openmailbox.org>
# jid: fanta@xmpp.linuxinthenight.com
# Se necesita tener curl instalado. En debian: apt-get install curl

af=frases.txt 			# Archivo con las frases. Una frase por línea.
nf=$(cat $af | wc -l) 		# Número de frases en el archivo con frases
na=$(( ( RANDOM % $nf )  + 1 )) # número aleatorio inicial entre 1 y el número de frases en el archivo con frases
te=3600				# Tiempo espera entre frase y frase en segundos. 3600s=1h
us=prueba 			# el nombre de la cuenta. Usuario
pw=123456			# La contraseña.
no=gnusocial.red		# Nodo.
pt=https			# https o http

while :
do
	fr=$(cat $af | head -$na | tail -1) # obtenemos una frase aleatoria
	curl -u $us:$pw -d status="$fr" $pt://$no/api/statuses/update.xml
	na=$(( ( RANDOM % $nf )  + 1 )) # generamos un número aleatorio nuevo
	sleep $te
done
