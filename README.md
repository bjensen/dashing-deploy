# Dashing-deploy

Dashing-deploy is a shell script to deploy
[Dashing](http://dashing.io/) on Ubuntu with nginx.  

```bash
$ git clone https://github.com/jakobadam/dashing-deploy.git
$ cd dashing-deploy
$ sudo ./install.sh
```

Point browser to http://serverip

Tested on:
* Ubuntu 14.04 Server

## Test with vagrant

**Note:** The box in the vagrant file is a vagrant-kvm box

```bash
$ vagrant up --provider=kvm
$ vagrant ssh 
$ cd /vagrant
$ ./install.sh
```
