https://towardsdatascience.com/connecting-to-an-ec2-instance-in-a-private-subnet-on-aws-38a3b86f58fb

To get started clone the repo:

   git clone https://github.com/HDaniels1991/AWS-Bastion-Host.git```

The repo requires you to have an AWS profile called: default. It is possible to change the profile name in the variables.tf file.

The next step is to generate the SSH keys. In the terraform directory create another directory called keys and create your keys with the following command:

# create the keys
ssh-keygen -f mykeypair

# add the keys to the keychain
ssh-add -K mykeypair  

# SSH Config File
# .ssh/config
# chmod 600 .ssh/config 

Host bastion-instance
   HostName <Bastion Public IP>
   User ubuntu

Host private-instance
   HostName <Private IP>
   User ubuntu
   ProxyCommand ssh -q -W %h:%p bastion-instance
