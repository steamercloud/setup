#!/bin/sh

export DISPLAY_LOCAL_STORE="/opt/oneops/display/public"

gem install  $OO_HOME/dist/oneops/dist/oneops-admin-1.0.0.gem --no-ri --no-rdoc

echo "inductor create"
cd $INDUCTOR_HOME
inductor create
cd inductor
# add inductor using shared queue
inductor add < /opt/inductor_answers
mkdir -p lib
cp $OO_HOME/client.ts lib/client.ts

echo "circuit init"
cd $INDUCTOR_HOME
rm -fr circuit
circuit create
cd circuit
bundle install
circuit init

echo "circuit-oneops-1 circuit install"
cd $INDUCTOR_HOME/inductor

if [ -d "circuit-oneops-1" ]; then
  echo "git pull circuit-oneops-1"
  cd circuit-oneops-1
  git pull
else
  echo "git clone circuit-oneops-1"
  git clone "$GITHUB_URL/circuit-oneops-1.git"
	cd circuit-oneops-1
fi
sleep 2

bundle install
circuit install

cd $INDUCTOR_HOME/inductor

inductor start
inductor tail
