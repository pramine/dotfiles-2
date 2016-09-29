#!/bin/sh

VERSION=$1
if [ -z $1 ]
then
  VERSION=`~/dotfiles/gitflow/bump-version-drynext.sh`
fi

cd $(git rev-parse --show-cdup)

#Initialize gitflow
git flow init -f -d

# ensure you are on latest develop  & master
git checkout develop
git pull origin develop
git checkout -

git checkout master
git pull origin master
git checkout develop

git flow release start $VERSION

~/dotfiles/gitflow/bump-version.sh $VERSION
git commit -am "Bumps version to $VERSION"

# bump released version to server
git push

#git checkout develop

# COMMENT LINES BELOW IF YOU BUMP VERSION AT THE END
#NEXTVERSION=`~/dotfiles/gitflow/bump-version-drynext.sh`
#~/dotfiles/gitflow/bump-version.sh $NEXTVERSION
#git commit -am "Bumps version to $NEXTVERSION"
#git push origin develop

