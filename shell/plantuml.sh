#!/usr/bin/bash

java -jar ~/.local/lib/java/plantuml.jar $@
#UML=$1
#FILE=`head -n1 $UML | awk '{print $2}'`
#if [ -n "$FILE" ]; then
    #EXT=${FILE##*.}
    #java -jar ~/.local/lib/java/plantuml.jar -t$EXT $@
    #echo $FILE
#else
    #java -jar ~/.local/lib/java/plantuml.jar $@
    #echo ${UML%.*}.png
#fi
