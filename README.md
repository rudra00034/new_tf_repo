# new_tf_repo
this is a simple main.tf file which will create an ec2 instance if the pre-req of aws cli configuration and terraform already installed, it uses pre-existing vpc,subnet,secretkey(ssh), security groups and outputs the public ip of the newly created instance.create a new branch by git checkout -b new_branch and stage this edited main.tf file by doing git add main.tf then commit by git commit -m "new ec2 instance" the push to remote by doing git push origin new_branch. then create a pr, get it approved and then merge it to master once it is on the git hub, developers can clone it to local. 
Once the re-req are met do **terraform init**, **terraform plan** and the **terraform apply**.
