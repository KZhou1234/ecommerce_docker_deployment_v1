## System diagram
<div>
  
![image](https://github.com/user-attachments/assets/ce222c1d-3061-4cd8-b6b4-161b67f0fc8e)

</div> 
## Instances
* Jenkins: t3.micro
* Jenkins Node: t3.medium
-  Not like previous projects, the pipeline and actual build, test, deploy stages will take place in Jenkins server, Jenkins Node will handle the heavier workload in this project, including the build, test, deploy and so on, so it requires more resources.
<div>
  <img width="527" alt="image" src="https://github.com/user-attachments/assets/0b57e383-874e-48e8-83a4-1da69d43d0e7">

</div>  

* Bastion Host: It is a gateway allowing secure access from administrators to the instances (frontend and backend) in private subnets.  
  1.  Security Group: Port 22 for SSH
  2.  eip (optional)
* App Server
  1. The load balancer will forward the HTTP traffic to the web tier. In this step, the load balancer facing the public internet will listen on port 80 and forward traffic to port 3000 on app server. To ensure the security, port 3000 will only open to load balancer security group.
  2. Configure the setting.py in backend server, modify the username and password for the database.
  3. <div>
    <img width="975" alt="image" src="https://github.com/user-attachments/assets/4bae5365-b46b-45d0-9284-0503eb2898e0">

  </div>  
  
  ## TROUBLE SHOOTING
  * terraform configuration:
  * 
 
## Database  
* One database reuqired for the data consistency, high effciency.
   - Set the primary instance as the endpoint. Under multi AZ setup, a standby replica will be created by AWS. Once the primary instance down or AZ level fail occurs, the standby instance will be connected to the satabase as the endpoint.

