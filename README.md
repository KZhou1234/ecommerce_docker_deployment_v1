## System diagram
<div>
  
  ![WL6 drawio](https://github.com/user-attachments/assets/2dc3f081-065f-446d-8985-8872fae47671)

</div> 
## Instances
* Jenkins: t3.micro
* Jenkins Node: t3.medium
-  Not like previous projects, the pipeline and actual build, test, deploy stages will take place in Jenkins server, Jenkins Node will handle the heavier workload in this project, including the build, test, deploy and so on, so it requires more resources.
<div>
  <img width="527" alt="image" src="https://github.com/user-attachments/assets/0b57e383-874e-48e8-83a4-1da69d43d0e7">

</div>  

* Bastion Host: It is a gateway allowing secure access the instances (frontend and backend) in private subnets.  
  1.  Security Group: Port 22 for SSH
  2.  eip (optional)
 
## Database  
* One database reuqired for the data consistency, high effciency.
   - Set the primary instance as the endpoint. Under multi AZ setup, a standby replica will be created by AWS. Once the primary instance down or AZ level fail occurs, the standby instance will be connected to the satabase as the endpoint.

