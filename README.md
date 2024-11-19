## PURPOSE
The purpose of this workload to to deploy the application to the target production environment through docker iamges also using Jenkins to implement CI/CD. We have the workload5 to figure out how to use terraform to prevesion the infrastruture into two different availability zones to improve the availability, in this workload, besides that we will also use dockers to simplify the process of deploying the application using created images. 
## System diagram
<div>
  
![image](https://github.com/user-attachments/assets/ce222c1d-3061-4cd8-b6b4-161b67f0fc8e)

</div> 

## Steps
1. Configure the Jenkins server, one manager server that use t3.micro and one node server which is t3.medium. The node server will handle the most work of creating the infrastructure, so it requires more hardware resources.
## Infrastructure
### Instances
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
  1. The app server contains the frontend, backend and database. In this wordload, no wpplication related resources will be exposed to the public. The developers can only access the apllication server through bastion host.
### Load Balancer
  * The load balancer will forward the HTTP traffic to the web tier. In this step, the load balancer facing the public internet will listen on port 80 and forward traffic to port 3000 on app server. To ensure the security, port 3000 will only open to load balancer security group.
### Security Groups
* Bastion Hosts: Only SSH required, so open port 22.
* App server: expose only to load balncer, so only traffic from load balancer will be allow. Open port 300 that running React to lg_sg

### Database  
 * One database reuqired for the data consistency, high effciency.
   - Set the primary instance as the endpoint. Under multi AZ setup, a standby replica will be created by AWS. Once the primary instance down or AZ level fail occurs, the standby instance will be connected to the satabase as the endpoint.  2. Configure the setting.py in backend server, modify the username and password for the database.
  3. <div>  
   
      <img width="975" alt="image" src="https://github.com/user-attachments/assets/4bae5365-b46b-45d0-9284-0503eb2898e0">

    </div>  
  
  ## TROUBLE SHOOTING
  * terraform configuration:
  * 
 
## Database  
*

