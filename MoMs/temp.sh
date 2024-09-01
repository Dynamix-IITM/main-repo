#!/usr/bin/bash

for i in ./*; do
	echo $i | sed 's/\.\//# /g';
	cat $i;
done
