#!/bin/bash
#This file takes an input line number and moves the line to a second input line number.

getLine()
{
	head -n$1 $2 | tail -n1;
	return 0;
}

removeLine()
{
	{ head -n$(( $1 - 1 )) "$3"; tail -n$(( $2 - $1 + 1)) "$3"; }
	return 0;
}

if [[ ! -r "$3" || ! -r "$3" ]]; then
	echo "Error: your file is either not valid, isn't readable, or isn't writable."
	exit -1;
fi

FILE_LENGTH=$(wc -l "$3" | cut -d " " -f1); 

if [[ $1 -gt $FILE_LENGTH ]]; then
	echo "Error: your first value is greater than the number of lines in the file"
	exit -1;	
fi

if [[ $1 -lt 1 ]]; then
	echo "Error: your first value is less than 1"
	exit -1;
fi

if [[ $2 -gt $FILE_LENGTH ]]; then
	echo "Error: your second value is greater than the number of lines in the file"
	exit -1;
fi

if [[ $2 -lt 1 ]]; then
	echo "Error: your second value is less than 1"
	exit -1;
fi

{ removeLine $1 $FILE_LENGTH "$3" | head -n$(($2 - 1)); getLine $1 "$3"; removeLine $1 $FILE_LENGTH "$3" | tail -n$(($FILE_LENGTH - $2 + 1)); }

exit 0;
