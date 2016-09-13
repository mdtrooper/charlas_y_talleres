#!/bin/bash
# bot2. Ejemplo de bot que busca 10 palabras clave en la red social y saca contenidos
# email: fanta <fantanaranja@openmailbox.org>
# jid: fanta@xmpp.linuxinthenight.com
# Se necesita tener curl instalado. En debian: apt-get install curl

# Keywords

filtro0="juntos podemos"
filtro1="podemos"
filtro2="pablo iglesias"
filtro3="unidos podemos"
filtro4="votar"
filtro5="la sonrisa de un país"
filtro6="el coletas"
filtro7="social democratas"
filtro8="26J"
filtro9="elecciones"

while read a ; do

	urluser="$a/rss"
	echo "$urluser"
	wget -q -t 1 --timeout=10 "$urluser" -O -| grep "<title>" | grep "</title>" | cut -d ">" -f 2 | rev | cut -d "<" -f 2 | rev | cut -d ":" -f 2-999 |  sed 's/^ *//' | grep -v "favorited something by" | grep -v "RT @" | grep -v "timeline" | grep -v "started following" | grep -v "deleted notice" | egrep -i -e "$filtro0|$filtro1|$filtro2|$filtro3|$filtro4|$filtro5|$filtro6|$filtro7|$filtro8|$filtro9" > shit.tmp
	ncoincidencias=$(cat shit.tmp | wc -l)
	checksum1=$(md5sum shit.tmp | cut -d " " -f 1)
	checksum2=$(md5sum shit2.tmp | cut -d " " -f 1)
	cp -pR shit.tmp shit2.tmp

	if [ "$ncoincidencias" = 0 ]; then
		echo "Nada nuevo bajo el sol"
	else
		# aquí entra cuando existen coincidencias
		# pero se comprueba igualmente que no sean las mismas
		if [ "$checksum1" = "$checksum2" ]; then
			# el checksum es igual por lo que no existe novedad
			echo "" >> /dev/null
		else
			# NO es igual el checksum
			echo "He encontrado chicha."
			cat shit2.tmp >> material.txt
		fi
	fi

	#sleep 1

done < listadousuarios.txt
