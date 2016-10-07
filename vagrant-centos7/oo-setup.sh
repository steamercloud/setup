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

echo -n "Do you want to execute OneOps validation script (y/n):"
read input
if [ $input == "y" -o $input == "yes" ]; then
	ruby oo-validation.rb
elif [ $input == "n" -o $input == "no" ]; then
	echo -n "******** Skipping OneOps Validation ********"
fi

now=$(date +"%T")
echo "All done at : $now"
