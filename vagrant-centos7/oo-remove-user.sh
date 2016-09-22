echo "****** deleting user ******"
export RAILS_ENV=development
export OODB_USERNAME=kloopz
export OODB_PASSWORD=kloopz
export LOG_DATA_SOURCE=es
export SESSION_INACTIVITY_TIMEOUT=999999
export PATH=${PATH}:/usr/local/bin

echo 'user=User.find_by username: "test"' > /opt/oneops/db/seeds.rb
echo 'User.destroy(user.id)' >> /opt/oneops/db/seeds.rb

cd /opt/oneops
rake db:seed
