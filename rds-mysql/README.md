# Create AWS RDS MySQL and AWS EC2 Instance
This document will show you how to create AWS RDS MySQL in two private subnets and Ubuntu server in one public subnet. In the end, we will achieve the following topology.

<img src="https://github.com/zhwpeng/tf-aws/assets/34671416/84f0aa7a-06d2-4913-bf99-df06baf737e1"></br>

Step 1. Install AWS CLI and Terraform.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform](https://www.terraform.io/downloads)

Step 2. Create secrets file.  
Create a secrets file called secrets.tfvars and populate it with the follow secrets:
```
  db_username: master user
  db_password: password of master user
  my_ip: public IP of you laptop. You can find it out via https://whatismyipaddress.com
```
Step 3. Create keypair.
```
ssh-keygen -t rsa -b 4096 -m pem -f tutorial_kp
openssl rsa -in tutorial_kp -outform pem > tutorial_kp.pem
chmod 400 tutorial_kp.pem
```
Step 4. Deploy.
```
terraform init
terraform apply -var-file="secrets.tfvars"
```
Step 5. Test.
```
ssh -i tutorial_kp.pem ubuntu@<public ip of ubuntu server>
sudo su -
apt install mysql-client
mysql -h <database-endpoint> -u <db-username> -p
show DATABASES;
```
