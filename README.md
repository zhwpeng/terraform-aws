# Create AWS EC2 instance in private subnet
This document will show you how to create AWS EC2 instance in private subnet and how to log into it. In the end, we will achieve [this topology](https://github.com/zhwpeng/tf-aws/blob/main/aws-private-subnet.png).

Step 1. Clone this repository.
```
  git clone https://github.com/zhwpeng/tf-aws.git
```
Step 2. This repository requires AWS CLI. Please follow [this document](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to install it.

Step 3. Create Access Key ID and Secret Access Key so AWS CLI can access AWS resources.
```
  Log into AWS Management Console -> IAM -> Users -> Security credentials -> Create access key
```
Step 4. This repository requires a AWS profile called default for authentication. Continue to run the following command to create default profile.
```
  aws configure 
```
  Enter Access Key ID and Secret Access Key which are created in step 3. The configuration will be saved to file $HOME/.aws/credentials. Check this file and make sure it looks similiar to the following: 
```
  [default]
  aws_access_key_id = <Access Key ID> 
  aws_secret_access_key = <Secret Access Key> 
```
Step 5. Create SSH keys which will be used to log into AWS EC2 instance.
```
  cd aws-one-zone or cd aws-three-zones
  mkdir keys
  cd keys
  ssh-keygen -f mykeypair
  ssh-add -K mykeypair  
```
Step 6. This repository also requires Terraform. Please follow [this document](https://developer.hashicorp.com/terraform/install) to install it.

Step 7. Deploy.
```
  cd aws-one-zone or cd aws-three-zones
  terraform init
  terraform apply
```
Step 8. Now two AWS EC2 instances will be created: bastion-instance and private-instance. Note down the public ip of bastion-instance and private ip of private-instance.
```
  cd $HOME/.ssh
  touch config
  chmod 600 config 
```
  Add the following into file config.
```
    Host bastion-instance
      HostName <Public IP> 
      User ec2-user

    Host private-instance
      HostName <Private IP> 
      User ec2-user
      ProxyCommand ssh -q -W %h:%p bastion-instance
```
Step 9. You can log into AWS EC2 instance in private subnet by running the following command.
```
  ssh private-instance
```
