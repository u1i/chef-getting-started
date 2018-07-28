# Chef - Infrastructure as Code

Let's get started with Chef! All you need is a Docker environment on your local machine to do this exercise.

Here are the components we'll be running:

* A **node** is any server or virtual server that is configured to be maintained by a chef-client. A node can be physical or cloud-based. A Chef organization comprises any combination of physical and cloud-based nodes. A chef-client runs on each node. Ohai is used to collect data about the system so that it is available to the chef-client during every Chef run.
* **Workstation**: A workstation is a computer that is configured to run Knife, to synchronize with the Chef repository, and interact with a single Chef Server. The workstation is the location from which most users of Chef will do most of their work..
* The **Chef Server** acts as a hub for configuration data. The Chef Server stores cookbooks, the policies that are applied to cookbooks, and metadata that describes each registered node in the infrastructure. Nodes use the chef-client to ask the Chef Server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef Server). This scalable approach distributes the configuration effort throughout the organization.

![](https://raw.githubusercontent.com/u1i/chef-getting-started/master/chef.png)