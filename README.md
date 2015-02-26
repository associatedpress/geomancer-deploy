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

Kick off a series of three scripts to set up the application stack.
We've sliced these scripts up to separate concerns a bit and make it 
easier to customize the scripts, if necessary.

Install OS dependencies and python environment setup
<pre>
# NOTE the use of sudo
cd geomancer-deploy
sudo ./bootstrap-1.sh
</pre>

Install and configure app code.
<pre>
# NOTE we do NOT sudo for this command
cd geomancer-deploy
./bootstrap-2.sh
</pre>

Activate web and data processing services and place them under process.
Requires passing in a domain or IP address string that will be used to
configure the nginx vhost.
<pre>
# NOTE the use of sudo and the 
cd geomancer-deploy
sudo ./bootstrap-3.sh geomancer.my_org.com

OR 

sudo ./bootstrap-3.sh 52.50.50.10
</pre>

### Open Firewall

After following the above steps to boostrap the environment, you must make Geomancer accessible on the internet. 
To do so, you'll need to open port 80 in your firewall for nginx.
This can be done in a variety of ways depending on your environment. 

Standard tools such as [iptables][] or [ufw][] can be used; or, if you're using
Amazon EC2, the [EC2 setup wizard][aws-ec2-setup] supports modification
of firewall rules.

[aws-ec2-setup]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html#create-a-base-security-group
[iptables]: https://help.ubuntu.com/community/IptablesHowTo
[ufw]: https://help.ubuntu.com/community/UFW
