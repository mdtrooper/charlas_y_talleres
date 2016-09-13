#!/bin/bash
# bot4. Ejemplo de bot que va sacando un listado de usuarios de gnusocial
# email: fanta <fantanaranja@openmailbox.org>
# jid: fanta@xmpp.linuxinthenight.com
# Se necesita tener curl instalado. En debian: apt-get install curl

te=1	# Tiempo espera entre usuario y usuario.  3600s=1h
urlfija="/api/statuses/friends.xml?count=100&screen_name="
nodoinicial="https://linuxinthenight.com" # url de un nodo en el que exista alguna cuenta
nickinicial="fanta" # el nick con el que comenzamos a extraer nombres
urlinicial="$nodoinicial$urlfija$nickinicial" # Url de un usuario para comenzar

while :
do
	wget -q "$urlinicial" -O - | grep -i "statusnet:profile_url" | cut -d ">" -f 2 | cut -d "<" -f 1 > shit.tmp
	cat shit.tmp >> listadousuarios.txt
	nusers=$(cat listadousuarios.txt | wc -l)
	cat listadousuarios.txt | sort | uniq > listadousuarios2.txt
	na=$(( ( RANDOM % $nusers )  + 1 )) # número aleatorio inicial entre 1 y el número de usuarios extraidos la última vez
        echo "sacando usuarios del usuario $nickinicial ($nusers)"
        raw=$(cat listadousuarios.txt | head -$na | tail -1)
	nodoinicial=$(echo "$raw" | cut -d "/" -f 1-3)
        nickinicial=$(echo "$raw" | cut -d "/" -f 4)
	urlinicial="$nodoinicial$urlfija$nickinicial"
	mv listadousuarios2.txt listadousuarios.txt
	rm -rf shit.tmp
	sleep $te
done
