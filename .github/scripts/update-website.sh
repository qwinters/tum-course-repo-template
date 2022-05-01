#!/bin/bash 

REPO_DIR=$(git rev-parse --show-toplevel)

if [[ -z $HOMEWORK_PASSWORD ]] ; then 
  for homework in $REPO_DIR/.build/*-solns.pdf ; do 
    enc_file="$(basename $homework .pdf)"
    qpdf --encrypt $HOMEWORK_PASSWORD $HOMEWORK_PASSWORD 256 -- $homework $enc_file
    cp "$REPO_DIR/.build/$enc_file" "$REPO_DIR/website/$enc_file"
  done
elif [[ -v PUBLISH_UNENCRYPTED_HOMEWORK ]] ; then
  cp "$REPO_DIR/.build/*-solns.pdf" "$REPO_DIR/website/"
fi 

cp $REPO_DIR/.build/*-notes.pdf $REPO_DIR/website
cp $REPO_DIR/.build/*-outline.pdf $REPO_DIR/website
cp $REPO_DIR/.build/*-ex-sheets.pdf $REPO_DIR/website 
cp $REPO_DIR/README.md $REPO_DIR/website/index.md

git add -f website/index.md

if [[ ! -z $(git status --porcelain) ]] ; then 
  GIT_USERNAME=$(git config user.name)
  GIT_EMAIL=$(git config user.email)

  git config user.name "GitHub Action" 
  git config user.email ""
  git commit -m "chore(website): Add updates to website"
  git push

  git config user.name $GIT_USERNAME
  git config user.email $GIT_EMAIL
fi 

