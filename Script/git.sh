#!/bin/sh 
MESSAGE="$1"
git add . -A
echo "All files added"
git commit -m "$MESSAGE"
echo "Commit added"
git push -u origin HEAD
echo "Commit pushed"