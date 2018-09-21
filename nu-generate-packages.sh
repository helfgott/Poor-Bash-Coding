#!/bin/bash
# mortiz
# Generate control files to compile deb packages
# we assume preinst and postinst instructions are available in the git repo
# Git repo is controled by Jenkins! so here I just take care of cleaning the local repo before doing anything.

BRANCH=$BRANCH
REPODIR='/srv/jenkins/build/'
BASEDIR=$PROJECT
DEBDIR='/DEBIAN'
FILENAME="/control"
FILE=$PROJECT$DEBDIR$FILENAME
VERSION=`date '+%Y%m%d%H%M'`
OUTPUTPKG='/srv/jenkins/available_packages'

if [[ $PROJECT == *['\ ''!'@#\$%^\&*()_+]* ]];then
	  echo 'Invalid project name'
	  echo "The format must be: my-project-name-xxxx"
	  exit 1
fi

if [ ! "${PROJECT: -4}" = 'xxxx' ];then
	echo 'Invalid project name'
	echo "The format must be: my-project-name-xxxx"
	exit 1
fi

if [ -z "$BRANCH" ]; then
	echo 'You must provide a valid branch'
	exit 1
fi

cd $REPODIR
git clean -fd
git reset

if [ "$(git checkout $BRANCH)" ]; then
	git checkout $BRANCH
	git fetch && git pull
else 
	echo  "$BRANCH is not a valid branch"
	exit 1
fi

if [ ! -d $PROJECT ]; then
	echo "The $PROJECT project does not exist"
	exit 1
fi

mkdir -p "$PROJECT/DEBIAN"

#!/bin/bash
if [ -e $FILE ]; then
	rm $FILE 
	touch $FILE
	echo "Package: $PROJECT" >> $FILE
	echo "Version: $VERSION" >> $FILE
	echo "Section: base" >> $FILE
	echo "Priority: optional" >> $FILE
	echo "Architecture: i386" >> $FILE
	echo "Maintainer: $1 <$2>" >> $FILE
	echo "Description: $DESCRIPTION" >> $FILE
  else
	touch $FILE
	echo "Package: $PROJECT" >> $FILE
	echo "Version: $VERSION" >> $FILE
	echo "Section: base" >> $FILE
	echo "Priority: optional" >> $FILE
	echo "Architecture: i386" >> $FILE
	echo "Maintainer: $1 <$2>" >> $FILE
	echo "Description: $DESCRIPTION" >> $FILE
fi

echo 'Building deb package...'
dpkg-deb --build $PROJECT $OUTPUTPKG/$PROJECT.deb 

echo 'End of generating .deb packages script'
