
system("sh /vagrant/create-oo-user.sh")

puts "*********************"
puts "creating organization"
puts "*********************"
`curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops -d '{ "name": "oneops" }' http://localhost:3000/account/organizations`

puts "*****************"
puts "creating assembly"
puts "*****************"
`curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops -d '{ "cms_ci": { "ciName": "validation", "ciAttributes": { "owner": "oneops@oneops.com" } } }' http://localhost:3000/oneops/assemblies`

puts "*****************"
puts "creating platform"
puts "*****************"
`curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops -d '{ "cms_dj_ci": { "comments": "creating platform for OO validation", "ciName": "tomcat", "ciAttributes": { "source": "main", "description": "tomcat platform", "pack": "tomcat", "version": "1" } } }' http://localhost:3000/oneops/assemblies/validation/design/platforms`

puts "**************"
puts "creating cloud"
puts "**************"
`curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops -d '{ "cms_ci" : { "ciName" : "openstack", "ciAttributes" : { "description" : "cloud for OO validation", "location" : "/public/oneops/clouds/openstack" } } }' http://localhost:3000/oneops/clouds`

puts "********************"
puts "creating environment"
puts "********************"
cloud=JSON.parse(`curl -X GET -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops http://localhost:3000/oneops/clouds/openstack`)
platform=JSON.parse(`curl -X GET -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops http://localhost:3000/oneops/assemblies/validation/design/platforms/tomcat`)
cloud_cid=cloud["ciId"]
platform_cid=platform["ciId"]
`curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops -d '{ "clouds": { "#{cloud_cid}":"1" }, "platform_availability": { "#{platform_cid}": "redundant" }, "cms_ci": { "ciName": "test", "nsPath": "oneops/validation", "ciAttributes": { "autorepair": "false", "monitoring": "true", "description": "OO validation environment", "dpmtdelay": "60", "subdomain": "test.validation.oneops", "codpmt": "false", "debug": "false", "global_dns": "true", "autoscale": "true", "availability": "redundant/single" } } }' http://localhost:3000/oneops/assemblies/validation/transition/test`

puts "*****************"
puts "commit and deploy"
puts "*****************"
release=JSON.parse(`curl -X GET -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops http://localhost:3000/oneops/assemblies/validation/transition/environments/test/releases/bom`)
latest_release_id=release["releaseId"]

`curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -u oneops:oneops -d '{ "cms_deployment": { "releaseId": "#{latest_release_id}", "nsPath": "/oneops/validation/test/bom" } }' http://localhost:3000/oneops/assemblies/validation/transition/environments/test/deployments`
