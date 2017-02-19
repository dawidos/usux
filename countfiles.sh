#!/bin/bash

ARG2=${2:-""}
ARG3=${3:--}

if [ "$ARG2" = "d" ] || [ "$ARG2" = "l" ] || [ "$ARG2" = "-" ]
	then
	ARG3=$ARG2
    ARG2=""
    echo "Non Recursive"
elif [ ! "$ARG2" = "d" ] && [ ! "$ARG2" = "l" ] && [ ! "$ARG2" = "-" ] && [ ! "$ARG2" = "R" ] && [ ! "$ARG2" = "" ]
    then
    echo "Wrong arg2, showing number of files in non recursive way"
    ARG2=""
elif [ "$ARG2" = "R" ]
    then
    echo "Recursive"
elif [ "$ARG2" = "" ]
    then
    echo "Non Recursive"
else
    echo "Try again. Correct usage: folder option1[R] option2[d,-,l]" >&2
fi


if [ $# -gt 0 ] && [ $# -lt 4 ] && [ -r $1 ] && [ $ARG3 = "d" ]
then
    echo "Number of folders:  "
    ls  -l$ARG2 $1 | grep ^$ARG3 -c #| wc -l
elif [ $# -gt 0 ] && [ $# -lt 4 ] && [ -r $1 ] && [ $ARG3 = "-" ]
then
    echo "Number of files  "
    ls  -l$ARG2 $1 | grep ^$ARG3 -c #| wc -l
elif [ $# -gt 0 ] && [ $# -lt 4 ] && [ -r $1 ] && [ $ARG3 = "l" ]
then
    echo "Number of links:  "
    ls  -l$ARG2 $1 | grep ^$ARG3 -c #| wc -l
elif [ $# -lt 0 ] || [ $# -gt 4 ]
then
   echo "Try again. Correct usage: folder option1[R] option2[d,-,l]" >&2
elif [ ! -r $1 ]
then
   echo "The file is not readable" >&2
else
    echo "Try again. Correct usage: folder option1[R] option2[d,-,l]" >&2
fi
