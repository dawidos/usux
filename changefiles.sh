#!/bin/bash -x


string="Changing text:  \"$2\" to text:  \"$3\" from a file \"$1\""
y=$(echo $(ls -d $1.*[0-9]* | sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/'))
max=0

for v in $y
do
if [ $v -gt $max ]
then
max=$v
fi
done

max=$((max + 1))

if [ $# -eq 3 ] && [ -f $1 ] && [ -r $1 ]
then
    printf '%s\n' "$string"
    sed "s/$2/$3/g" $1>$1.$max
    echo "And saving the result in a file called \"$1.$max\""
elif [ $# -ne 3 ]
then
   echo "Try again. Correct usage: change file text1 text2" >&2
elif [ ! -f $1 ]
then
   echo "File $1 does not exist." >&2
elif [ ! -r $1 ]
then
   echo "The file is not readable" >&2
fi
