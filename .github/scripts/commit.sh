#!/bin/bash 

REPO_DIR="$(git rev-parse --show-toplevel)"

git checkout main
git add -f "$REPO_DIR"/.build/*.pdf
git add -f "$REPO_DIR"/*.tex 

if [[ ! -z $(git status --porcelain) ]] ; then 
  GIT_USERNAME=$(git config user.name)
  GIT_EMAIL=$(git config user.email)

  git config user.name "GitHub Action"
  git config user.email ""
  git commit -m "chore(LaTeX): Compile and update PDFs"
  git push

  git config --global user.name $GIT_USERNAME
  git config --global user.email $GIT_EMAIL
fi

