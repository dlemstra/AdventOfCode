#!/bin/bash
set -e

kotlinc *.kt -d main.jar
kotlin -classpath main.jar aoc.test