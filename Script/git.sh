#!/bin/sh 

. Script/foundation.sh

MESSAGE="$1"
git add . -A
print "All files added"
git commit -m "$MESSAGE"
print "Commit added"
git push -u origin HEAD
print "Commit pushed"