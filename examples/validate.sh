#!/bin/sh
set -e
echo "Home: $HOME"

cd $1
go mod tidy
mm.py README.md
echo "===================={{$1}}  mm.py exit: {{$?}}"