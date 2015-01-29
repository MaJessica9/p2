#! /bin/bash

if [[ "$#" -eq 0 ]]
then
  echo Executable name required.
  echo usage: makemake.sh executable_name
else 									          	    # initialize Makefile
  # Line 1
  echo -n "$1 :">Makefile
  for f in *.cpp ; do                 # finds all .cpp files
    f2=${f%.*}.o                      # changes them to .o strings
    echo -n " $f2">>Makefile          # appends the new string to the Makefile
  done # for
  echo>>Makefile                      # adds a new line

  # Line 2
  echo -e -n '\tg++ -ansi -Wall -g -o' "$1">>Makefile
  for f in *.cpp ; do                 # for every .cpp file
    f2=${f%.*}.o 
    echo -n " $f2">>Makefile          # appends the new string to the Makefile
  done # for
  echo>>Makefile 
  echo>>Makefile

  # Line 3+
  for f in *.cpp ; do                 # for every .cpp file
    f2=${f%.*}.o
    echo -n "$f2 :">>Makefile 
    echo -n " $f">>Makefile
    awk '/"*.h"/ {print $2}' $f > out.txt # search for .h
    g=$(sed 's/"//g' out.txt)              # remove the "" in the line
    echo -n " $g">>Makefile
    echo>>Makefile  
  
    # Line 4+
    echo -e -n '\tg++ -ansi -Wall -g -c' "$f">>Makefile
    echo>>Makefile 
    echo>>Makefile
    done
  rm out.txt
fi



# Helpful Hints
# Echo Tabs: echo -e ' \t' 
#   -e: enable interpret of backslash
#   ' \t': tab 
