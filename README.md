# Session 01 - Introduction into developing Puppet code

Today we will deploy a webserver using Puppet to install apache.\
We will use the following resources:

- package
- file_line
- service
- file

We will also be adding a variable to be used in a (file) template.

## Prerequisites

- WSL image: workshop-azure-app
  - If you don't have this already installed, you can read the download instructions on: [github.com](https://github.com/tooling-automation/workshop-azure-apps?tab=readme-ov-file)
- You will also need to install the puppet agent on you WSL. To do this you will need to run the following command:

``` bash
apt-get install puppet-agent
```

- You will need to create a file to store your code: `apache.pp` for example. The folder can be your (root) home dir.

## Puppet resources

Each resource describes the desired state for some aspect of a system, like a specific service or package. When Puppet applies a catalog to the target system, it manages every resource in the catalog, ensuring the actual state matches the desired state.

Frequently used resources:

- cron
- exec
- file
- group
- notify
- package
- service
- user

When Puppet applies the compiled catalog, it:\
Reads the actual state of the resource on the target system.

Compares the actual state to the desired state.

If necessary, changes the system to enforce the desired state.

Logs any changes made to the resource. These changes appear in Puppet agent's log and in the run report, which is sent to the primary server and forwarded to any specified report processors.

If the catalog doesn't contain a particular resource, Puppet does nothing with whatever that resource described. If you remove a package resource from your manifests, Puppet doesn't uninstall the package; instead, it just ignores it. To remove a package, manage it as a resource and set ensure => absent.

### Tip: Nice to watch [YouTube - Resourses | Puppet Language Basics](https://youtu.be/fMTQvqZZH7g)

A resource is writen as:

``` puppet
resource_type { 'name':
  attribute => value,
}
```

Almost all resources have at least one attrubute called: `ensure`. The value of ensure depends on the resource type. Common values for ensure are: `absent` or `present` but for a package it can also be set to represent the desired version of the package or even set to 'latest' if you want Puppet to update the package every time a new version is released.

### Also nice to watch [YouTube - How Puppet works](https://www.youtube.com/watch?v=QFcqvBk1gNA)

## puppet apply

Normally you would enter the following command: `puppet agent -t` to apply your code\
But when developing Puppet code you don't need to do puppet runs from the Puppet Server. You can also do local puppet runs with:

``` bash
puppet apply apache.pp
```

This will run your Puppet Code as if it was from a Puppet Server.

## Exercise 1 - puppet resource package

To install Apache you need to ensure that the `Apache2` package is present.

It is now up to you to add this resource to your code

### Tip: Google [puppet resource package](https://www.google.com/search?q=puppet+resource+packge&rlz=1C1VDKB_nlNL1039NL1039&oq=puppet+resource+pa&gs_lcrp=EgZjaHJvbWUqBggAEEUYOzIGCAAQRRg7MgYIARBFGDkyDggCECMYExgnGIAEGIoFMgoIAxAAGBMYFhgeMgoIBBAAGBMYFhgeMgoIBRAAGBMYFhgeMgcIBhAAGO8FMgYIBxBFGDzSAQg1MDc3ajBqN6gCCLACAQ&sourceid=chrome&ie=UTF-8)

After running `puppet apply apache.pp` you should be able to go to the ip address of your WSL in a browser and see your apache default home page.

## Exercise 2 - puppet resource file_line

Now that Apache is running we want to change the port that your server is listening to. For this we need to edit `/etc/apache2/ports.conf`.\
In this file you can find the line: `Listen 80` and you will need to change this to `Listen 8080`.

Ofcource you don't want to do this manually, you want Puppet to do this for you.\
You could replace the whole file with your own copy. But then you could loose other important changes.
So it would be better to only edit 1 line in the file. For this you can use the `file_line` resource.

Go ahead and update your code to change the port from `80` to `8080` using the `file_line` resource.

### Tip: Google [puppet resource file_line](https://www.google.com/search?q=puppet+resource+file_line&rlz=1C1VDKB_nlNL1039NL1039&oq=puppet+resource+fil&gs_lcrp=EgZjaHJvbWUqEAgAEEUYExgnGDsYgAQYigUyEAgAEEUYExgnGDsYgAQYigUyEAgBEEUYExgnGDsYgAQYigUyBggCEEUYOzIGCAMQRRg5MgoIBBAAGBMYFhgeMgYIBRBFGDwyBggGEEUYPDIGCAcQRRg80gEKMzk4NjEzajBqN6gCALACAA&sourceid=chrome&ie=UTF-8)

### Tip2: [Resource Type: file_line, Match Example](https://www.puppetmodule.info/modules/puppetlabs-stdlib/4.25.1/puppet_types/file_line#:~:text=file%20/etc/sudoers.-,Match%20Example%3A,-file_line%20%7B%20%27bashrc_proxy%27%3A%0A%20%20ensure)

After doing another `puppet apply apache.pp` you can check the `/etc/apache2/ports.conf` file to see that the file has been updated.

You will also need to restart the `apache2 service` to see the change work but we will also be using Puppet to do this in the next exercise.

## Exercise 3 puppet resource service

In the previous exercises we installed Apache2 and also changed the port on which the webserver will be listening. But to activate the port change we must restart the `apache2` service. Perhaps you did this manually anyway in the previous exercise but that is not how we want to work on a daily basis.\
\
To restart the `apache2` service we let puppet manage the service. Because Puppet manages the desired state it does not have a setting to restart the service. The end desired state is that the services is `running`. So you can set the service to `ensure => running` but this would not restart the service if needed.\
\
So in this exercise you will search for a way to restart the service.

### Tip: Google [puppet resource service](https://www.google.com/search?q=puppet+resource+service&rlz=1C1VDKB_nlNL1039NL1039&oq=puppet+resource+s&gs_lcrp=EgZjaHJvbWUqEAgAEEUYExgnGDsYgAQYigUyEAgAEEUYExgnGDsYgAQYigUyBggBEEUYOTIKCAIQABgTGBYYHjIKCAMQABgTGBYYHjIKCAQQABgTGBYYHjIGCAUQRRg8MgYIBhBFGDwyBggHEEUYPNIBCDQ5MjZqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8)

After running `puppet apply apache.pp` you should be able to go to the ip address of your WSL in a browser and see your apache default home page.\
[http://<<your_ip_addess:8080>>](http://<<your_ip_addess:8080>>)

## Exercise 4 Modify the homepage using an epp template file

Now that we have the webserver up and running on our own desired port, we need to change the homepage to show that we did it.

For this you first need to create a new Embedded Puppet Template file (*.epp) called `home-page.epp` and add the follow line:

``` epp
Congratulations <%= $username %> You did it :-)
```

In your `apache.pp` file you will also need to add a variable to your code called: `$username`\
Set the $username variable to your own first name:

``` pp
$username = <<your first name>>
```

It is now up to you to manage the default homepage to use the template.

### Tip: With Apache2 on Ubuntu the homepage file is located at /var/www/html/index.html

### Tip2: Google [puppet resource file](https://www.google.com/search?q=puppet+resource+file&rlz=1C1VDKB_nlNL1039NL1039&oq=puppet+resource+file&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIOCAEQIxgTGCcYgAQYigUyBggCEEUYOzIKCAMQABgTGBYYHjIKCAQQABgTGBYYHjIGCAUQRRg8MgYIBhBFGDwyBggHEEUYPNIBCDcyODBqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8)

### Tip3: Also read [Puppet EPP emplates](https://www.puppet.com/docs/puppet/7/lang_template_epp#lang_template_epp)

### Tip4: [To call a template from your code](https://www.puppet.com/docs/puppet/7/lang_template_epp#lang_template_epp:~:text=To%20call%20this%20template%20from%20a%20manifest)

When finished you can do another `puppet apply apache.pp` and you should see your new personal webpage.

## Exercise 5 Puppet resourc dependancies

After seeing your personal webpage you may have thought that you were done. But there is one detail that we didn't tell you.\
Puppet doesn't always run code from top to bottom. So you may need to tell Puppet in which order to update a resource.\
You can't manage a service if it hasn't been installed by the package first.\
The same goes for files. If the file is installed by a package then you may need to first install the package and then manage the file.\
\
If you havn't already done this then you will also need to do the following:

- the file_line resource needs to require the apache2 package
- the service resource needs to subscribe to the file_line resource. This ensures that the service restarts everytime the file is updated.
- the file resource needs to require the apache2 package

### Tip: Google [puppet resource dependancies](https://www.google.com/search?q=puppet+resource+dependencies&rlz=1C1VDKB_nlNL1039NL1039&oq=puppet+resouce+dep&gs_lcrp=EgZjaHJvbWUqCAgBEAAYFhgeMgYIABBFGDkyCAgBEAAYFhgeMggIAhAAGBYYHjIKCAMQABiiBBiJBTIHCAQQABjvBTIKCAUQABiABBiiBDIHCAYQABjvBdIBCDQ5MzVqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8)

### Tip2: Nice to watch [Metaparameters](https://youtu.be/gz9Nb6j6dss)

## Exercise 6 Clean up

Now that we have finished, it is time to clean up.

Create a `cleanup.pp` and add the following:

``` puppet
package { 'apache2':
  ensure => absent
}
```

run: `puppet apply remove.pp`

This will remove the apache2 package, which will also remove all other resources.

You can also remove the Puppet agent with:

``` bash
apt remove install puppet-agent
```
