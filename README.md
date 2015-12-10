# geomancer-deploy
Scripts and configs for provisioning Ubuntu as a host for [Geomancer][].

## Bootstrapping

We've provided three _bootstrap_ scripts to help set up the application stack.  
We sliced these scripts up to separate concerns a bit and make it easier 
to customize for different environments.

The scripts install and configure the following software: 

* [Geomancer][] - application code
* [nginx][] - web server (proxies to [gunicorn][])
* [gunicorn][] - application server
* [redis][] - key/value data store
* [supervisor][] - process management for gunicorn and Geomancer workers


### Initial bootstrap

> Below was tested on Ubuntu 14.04.  You may need to modify these configs and scripts to suit your OS.

Before running the bootstrap scripts, you must ssh to your server and
perform a few manual steps. Below assumes you have ssh access properly
set up.

<pre>
ssh ubuntu@yourserver.org
</pre>


Install git and pull down the [geomancer-deploy][] repo from Github.
<pre>
sudo apt-get install git
mkdir code
cd code
git clone https://github.com/associatedpress/geomancer-deploy.git
</pre>



### Install Dependencies

Install OS dependencies and set up python environment.

>  Note the use of sudo below!!

<pre>
cd geomancer-deploy
sudo ./bootstrap-1.sh
</pre>

### Install/configure app code

Install and configure app code.

> Note we do NOT use sudo for this command!!

<pre>
./bootstrap-2.sh
</pre>

### Activate App and Services

Activate web app and data processing workers and place them under process control.
Requires passing in a domain or IP address string that will be used to
configure the nginx vhost.

> Note that once again we must use sudo!!!
> Also, don't forget to pass in a domain and/or IP address parameter!

<pre>
sudo ./bootstrap-3.sh geomancer.my_org.com
OR 
sudo ./bootstrap-3.sh 52.50.50.10
</pre>

### Open Firewall

After following the above steps to boostrap the environment, you must make Geomancer accessible on the internet. 
To do so, you'll need to open port 80 in your firewall for nginx.
This can be done in a variety of ways depending on your environment. 

Standard tools such as [iptables][] or [ufw][] can be used; or, if you're using
Amazon EC2, the [EC2 setup wizard][aws-ec2-setup] supports configuration of firewall rules.

### Reloading App Code

The default installation relies on [supervisor][] to manage the gunicorn
application server, along with several worker processes for wrangling data.

After deploying a code update, you can restart one or more application
services using the below commands.

<pre>

# Display names of geomancer processes
# This is useful if you don't know the names of the worker processes
sudo supervisorctl status

# Restart appication server process
sudo supervisorctl restart geomancer

# Restart one worker process
sudo supervisorctl restart geomancer_worker:geomancer_worker_01

# Restart all processes (use with caution if other apps are managed by
# supervisor on your system)
sudo supervisorctl restart all

</pre>


[aws-ec2-setup]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html#create-a-base-security-group
[geomancer]: https://github.com/associatedpress/geomancer
[geomancer-deploy]: https://github.com/associatedpress/geomancer-deploy
[iptables]: https://help.ubuntu.com/community/IptablesHowTo
[nginx]: http://nginx.com/
[gunicorn]: http://gunicorn.org/
[redis]: http://redis.io/
[supervisor]: http://supervisord.org/
[ufw]: https://help.ubuntu.com/community/UFW
