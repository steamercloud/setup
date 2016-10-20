#!/bin/sh

mkdir -p /home/oneops
cd /home/oneops

export BUILD_BASE='/home/oneops/build'
export OO_HOME='/home/oneops'
export GITHUB_URL='https://github.com/oneops'

mkdir -p $BUILD_BASE

if [ -d "$BUILD_BASE/dev-tools" ]; then
  echo "doing git pull on dev-tools"
  cd "$BUILD_BASE/dev-tools"
  git pull
else
  echo "doing dev tools git clone"
  cd $BUILD_BASE
  git clone "$GITHUB_URL/dev-tools.git"
fi
sleep 2

cd $OO_HOME

cp $BUILD_BASE/dev-tools/setup-scripts/* .

export PATH=$PATH:/usr/local/bin

./oneops_build.sh "$@"

oo_validation_flag=$( echo "$1" | tr -s  '[:upper:]'  '[:lower:]' )
echo "OneOps Validation flag is:"$oo_validation_flag

if [ -z  $oo_validation_flag ]; then
  echo "******** Skipping OneOps Validation ********"
elif [ $oo_validation_flag == "y" -o $oo_validation_flag == "yes" ]; then
	ruby oo-validation.rb
fi

now=$(date +"%T")
echo "All done at : $now"
