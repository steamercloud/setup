#!/bin/sh

export RAILS_ENV=development
export OODB_USERNAME=kloopz
export OODB_PASSWORD=kloopz
export LOG_DATA_SOURCE=es

echo "Deploying display component: $now "

mkdir -p /opt/oneops
cd /opt/oneops

# backup current app director if it exists
# if [ -d display ]; then
#   rm -fr display~
#   mv display display~
# fi

mkdir -p /opt/oneops/display
cd /opt/oneops/display

tar -xzvf $OO_HOME/dist/oneops/dist/app.tar.gz

bundle install

dbversion=$(rake db:version | grep "Current version:" | awk '{print $3}')
echo "Current db version" $dbversion
if [ "$dbversion" ==  "0" ]; then
   rake db:setup
fi

rake db:migrate

now=$(date +"%T")
echo "Done with rails deployment: $now"

rails server
