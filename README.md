# geomancer-deploy
Scripts and configs for provisioning Ubuntu as a host for geomancer.

## Bootstrapping

_Below was developed and tested on a default install of Ubuntu 14.04 server edition on AWS.
You'll need to modify the configs appropriately depending on your server environment._

<pre>
# Below assumes you have ssh access set up already
ssh ubuntu@yourserver.org
</pre>


Install git and pull down geomancer deployment repo from Github
<pre>
sudo apt-get install git
mkdir code
cd code
git clone https://github.com/associatedpress/geomancer-deploy.git
</pre>

Create the GEOMANCER_SERVER_NAME environment variable. This should be set to a public IP address or domain
 (this will be added to the nginx configuration to make the site available at that address)
<pre>
export GEOMANCER_SERVER_NAME="52.50.50.10"
or
export GEOMANCER_SERVER_NAME="geomancer.mynewsorg.com
</pre>


Kick off the top-level shell script, _bootstrap.sh_. This script invokes
several related shell scripts responsible for installing and configuring 
the Geomancer stack and its dependencies.
<pre>
cd /home/ubuntun/code/geomancer-deploy
sudo ./bootstrap.sh
</pre>


### Open Firewall

To make Geomancer accessible on the internet, you'll need to open port 80 in your firewall for nginx.
This can be done in a variety of ways depending on your environment. 

Standard tools such as iptables or FW can be used; or, if you're using
Amazon EC2, the [EC2 setup wizard][aws-ec2-setup] supports modification
of firewall rules.

[aws-ec2-setup]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html#create-a-base-security-group
