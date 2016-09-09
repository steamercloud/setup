echo "*************"
echo "creating user"
echo "*************"
export RAILS_ENV=development
export OODB_USERNAME=kloopz
export OODB_PASSWORD=kloopz
export LOG_DATA_SOURCE=es
export SESSION_INACTIVITY_TIMEOUT=999999
export PATH=${PATH}:/usr/local/bin
echo 'User.create!({ :email => "oneops@oneops.com", :authentication_token => "oneops", :name => "oneops", :username => "oneops", :eula_accepted_at => Time.now, :password => "oneops" })' > /opt/oneops/db/seeds.rb
cd /opt/oneops
rake db:seed