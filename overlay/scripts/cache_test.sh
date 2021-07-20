#!/bin/bash
set -e
pageload1=`curl http://www.worldtimeapi.org/api/timezone/ETC/GMT --resolve www.worldtimeapi.org:80:127.0.0.1`
sleep 5
pageload2=`curl http://www.worldtimeapi.org/api/timezone/ETC/GMT --resolve www.worldtimeapi.org:80:127.0.0.1`
sleep 5
pageload3=`curl http://worldtimeapi.org/api/timezone/ETC/GMT --resolve worldtimeapi.org:80:127.0.0.1`
sleep 5
pageload4=`curl http://worldtimeapi.org/api/timezone/ETC/GMT --resolve worldtimeapi.org:80:127.0.0.1`
if [ "$pageload1" == "$pageload2" ]; then
	if [ "$pageload3" == "$pageload4" ]; then
		if [ "$pageload1" == "$pageload4" ]; then
			echo "Succesfully Cached"
			exit 0
		else
			#In generic pages 1+4 should be identical as all domains are cached equally
			echo "Error caching test page, pages 1+4 are different"
			exit -3
		fi

	else
		echo "Error caching test page, pages 3+4 different"
		exit -2
	fi

else
	echo "Error caching test page, pages 1+2 different"
	exit -1
fi
