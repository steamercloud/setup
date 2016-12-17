# Overview

This repository contains the necessary tooling to start and run a local OneOps instance using Vagrant without
metrics collection. The result is a simplified design that is deployed from bash scripts.

For a full-deployment of OneOps with metrics (back loop), use the core assembly within this vagrant image.

# Prerequisites

- VirtualBox
- Vagrant (version 1.8 or above)

# Installation

Once you have these installed the prerequisites, run `vagrant up`:


```bash
git clone https://github.com/oneops/setup
cd setup/vagrant-centos7
vagrant up 
```

Installation takes about 20 min depending on your internet connection.

Once the process completed you can access OneOps at http://localhost:9090.

Next steps are

- Sign Up (create local user / org)
- Create a Cloud,
- Create an Assembly
- Create an Environment

Then you can create and deploy an application.

More detailed information and additional resources can be found on the
[OneOps website](http://oneops.com/admin/getting-started/installing-vagrant-image.html).

You can access the deployment logs with:

```bash
cd /opt/oneops/inductor
inductor tail
```

