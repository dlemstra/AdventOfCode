#!/bin/bash
set -e

file=`ls -1t *.kt | head -1`
if [ "$file" -nt "main.jar" ]; then
    kotlinc *.kt -d main.jar
fi
kotlin -classpath main.jar aoc.MainKt