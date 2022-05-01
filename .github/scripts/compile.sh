#!/bin/bash 

for file in *.tex ; do 
  latexmk -f -pdf -interaction=nonstopmode -outdir=.build $file
done

