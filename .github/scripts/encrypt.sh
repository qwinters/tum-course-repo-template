#!/bin/bash

CURR_DIR="$(PWD)"
REPO_DIR="$(git rev-parse --show-toplevel)"

cd $REPO_DIR

for assignment in homework* ; do 
    cd $assignment
    for pdffile in *.pdf ; do 
        encfile="$(basename $pdffile .pdf)-enc.pdf"
        qpdf --encrypt $HOMEWORK_PASSWORD $HOMEWORK_PASSWORD 256 -- $pdffile $encfile
    done 
    cd .. 
    if [[ ! -d gh-pages/"$assigment" ]] ; then 
        mkdir -p gh-pages/"$assignment"
    fi
    mv "$assignment"/*-enc.pdf gh-pages/"$assignment"
done 

cd $CURR_DIR
