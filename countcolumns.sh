#!/bin/bash


if [ "$1" = "-a" ] && [ -f $2 ]
then
    fname=$2
    option=true
elif [ -f $1 ]
then
    fname=$1
    option=false
else
    echo "File does not exist or invalid usage" >&2
    echo "Try again. Correct use: filename [-a] nr of columns" >&2
    exit
fi

if [ $# -lt 1 ]
then
   echo "Try again. Correct use: filename [-a] nr of columns" >&2
elif [ ! -r $fname ]
then
    echo "File is not readable"
fi


if [ $# -eq 1 ]
then
    #mamy tylko plik i nie mamy info o kolumnach wiec sumujemy wszystkie kolumny
    echo "The only argument you passed is a filename: $fname"
    awk 'BEGIN{print("Column (vector) as a score of sum of columns: ")}
    { for(i=1; i<=NF;i++) sum+=$i; print sum; sum=0}' $fname
elif [ $# -eq 2 ] && [ "$option" = true ]
then
    #mamy tylko plik ale i opcje A wiec sumujemy kolumny i na koncu sumujemy wynik
    echo "You passed a filename and option -a as arguments"
    awk '{for (i=1;i<=NF;i++) sum+=$i };
         END{print("Final score (scalar) of sum of columns: "sum)}' $fname

elif [ $# -gt 1 ] && [ "$option" = false ]
then
    # mamy plik i liste kolumn do liczenia
    echo "You passed a filename and columns numbers as arguments"
    #n= number of arguemnts -1
    #n=$(($#-1))
    for x in ${@:2}
        do
        if [ "$x" -eq "$x" ] && [ $x -gt 0 ]
        then
            echo "$x is natural number"
        else
            echo "ERROR:parameter $x must be natural number and it is not. Try again" 2>/dev/null
            exit
        fi
        done
        #echo ${@:2}

    d=${@:2}
    echo "Sum(vector) of columns ${@:2} is"
    awk -v c="$d" 'BEGIN {split(c,a," ")}{c=0; for(i in a) c+=$a[i]; print c}' $fname

elif [ $# -gt 1 ] && [ "$option" = true ]
then
    # mamy plik i liste kolumn do liczenia z opcją -a
    echo "You passed a filename and columns numbers and option -a as arguments"
    for y in ${@:3}
        do
        if [ "$y" -eq "$y" ] && [ $y -gt 0 ]
        then
            echo "$y is natural number OK"
        else
            echo "ERROR:parameter $y must be an natural number and it is not. Try again" 2>/dev/null
            exit
        fi
        done
    x=0
    for i in ${@:3}
    do
        part=$(awk -v var=$i '{sum+=$var};
                       END{print(sum)}' $fname )
        x=$(( x + part ))
    done
    echo "Sum of columns nr: ${@:3} :"
    echo $x
else
    echo "Error :("
    exit
fi
