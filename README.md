overview
=====

This is a local OneOps instance using Vagrant without metrics collections.  It's a simplified design deployed from bash scripts.  

For a full-deployment of OneOps with metrics (back loop) use the core assembly within this vagrant image.

prerequisites
=======

install VirtualBox and Vagrant

(until public) add your public ssh key to your account at github.com


install
=======

Once you have these installed run: 

```bash
git clone https://github.com/oneops/setup
cd setup/vagrant
vagrant up 
```

Installation takes about 20 min, depending on your internet connection.
After it is up hit http://localhost:9090

You will have to Sign Up (create local user / org) and then create a Cloud, Assembly, and Environment to deploy something.

More detailed info on that process [here](http://oneops.github.io/admin/getting-started/#installing-vagrant-image).

To see the deployment logs:

```bash
cd /opt/oneops/inductor
inductor tail
```

