#!/usr/bin/env sh 

REPO_DIR="$(git rev-parse --show-toplevel)"

if [[ -z "$FILE_PREFIX" ]] ; then 
  files_to_move=(notes.tex ex-sheets.tex ex-solns.tex outline.tex)
  for file in $files_to_move ; do 
    if [[ -f "$REPO_DIR/$file" ]] ; then 
      mv "$REPO_DIR/$file" "$REPO_DIR/$FILE_PREFIX-$file"
    fi
  done
fi 

for file in $(ls $REPO_DIR/*.tex) ; do 
  latexmk -f -pdf -interaction=nonstopmode -outdir=.build $file
done

git add -f "$REPO_DIR"/.build/*.pdf
git add -f "$REPO_DIR"/*.tex 

if [[ ! -z $(git status --porcelain) ]] ; then 
  git config --global user.name "GitHub Action"
  git commit -m "chore(LaTeX): Compile and update PDFs"
  git push
fi 
