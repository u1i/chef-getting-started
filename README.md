# Chef - Infrastructure as Code

Let's get started with Chef! All you need is a Docker environment on your local machine to do this exercise.

Here are the components we'll be running:

* A **Node** is any server or virtual server that is configured to be maintained by a chef-client. A node can be physical or cloud-based. A Chef organization comprises any combination of physical and cloud-based nodes. A chef-client runs on each node. Ohai is used to collect data about the system so that it is available to the chef-client during every Chef run.
* **Workstation**: A workstation is a computer that is configured to run Knife, to synchronize with the Chef repository, and interact with a single Chef Server. The workstation is the location from which most users of Chef will do most of their work using **knife**
* The **Chef Server** acts as a hub for configuration data. The Chef Server stores cookbooks, the policies that are applied to cookbooks, and metadata that describes each registered node in the infrastructure. Nodes use the chef-client to ask the Chef Server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef Server). This scalable approach distributes the configuration effort throughout the organization.

![](https://raw.githubusercontent.com/u1i/chef-getting-started/master/chef.png)

# 1 - Run Chef Server

`docker run --name chef-server -d -p 443:443 u1ih/chef-server:latest`

This will run a new container and install Chef Server, which might take a moment to complete. Check `docker logs chef-server` to see the progress. Proceed to the next step once https://localhost/version shows you that Chef Server is running.

# 2 - Run interactive Chef Workstation

`docker run -it --link chef-server u1ih/chef-workstation bash`

We'll use the **knife** tool for working with Chef. The container has a default ~/.chef/config.rb for you, already wired towards a chef server called chef-server, which is the linked container. We just need to import the server certs that were generated in the previous step. Inside the container shell do this:

`cd /root/.chef`
`curl -k --output - https://chef-server/knife_admin_key.tar.gz | tar -xvzf -`
`knife ssl fetch`

Now if you issue the command `knife user list` you should see the following output:

> admin

Keep that console open, this will be our workstation to interact with the other components.

# 3 - Run a Linux Node

We need infrastructure to play with, so Chef can install & configure stuff there via cookbooks. Let's use an Ubuntu container that also gives us SSH access (I know, I know...)

`docker run -d -p 8022:22 --link chef-server rastasheep/ubuntu-sshd:18.04`

You should know be able to ssh into this machine with

`ssh root@localhost -p 8022` and the password `root`.

# 4 - Bootstrap the Node from Knife

We can now go back to our Chef Workstation and use Knife to bootstrap that Linux node. In essence, we'll install `chef-client` and connect it to the Chef Server.

`knife bootstrap 172.17.0.1 -p 8022 -x root -P root`

(172.17.0.1 is the default IP address of the Docker host. Change it accordingly if it's different on your environment.)

After this completes, you should now see the configured node:

`knife node list`
> 9e5b80312a0e

# 5 - Install stuff on the Node

knife cookbook list

knife cookbook site download redis

knife cookbook download cookbook-name


http://www.devopsschool.com/tutorial/chef/knife-command-line-reference.html

https://docs.chef.io/chef_repo.html

https://downloads.chef.io/chefdk

$ chef generate repo REPO_NAME
