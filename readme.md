# Terraform AWS Checkly Private Location

This project is an example of using Checkly with a Private Location to check on resources within your AWS private network.

These resources would normally not be contactable from Checkly directly but with the help of a Private Location and a tool called Goss to serve as a local API, the resources can be monitored using Checkly.

Terraform is used to create a small EC2 instance to act as a Checkly Private location within a VPC, with additional resources such as a web server, an RDS instance and a Redis cache to perform checks on. Terraform also creates the Checkly checks to monitor the resources that are created thanks to the Terraform Checkly provider.

Once up and running, you will have a Checkly Dashboard available at https:/aws-checkly-private-location.checkly-dashboards.com/ monitoring your private resources.

To get up and running you will need:

* A Checkly account
* A Checkly API key and private location key.
* Terraform v1.2.3

### Estimated cost
Cost estimate taken from Infracost

```
Project: terraform_aws_checkly_private_location

 Name                                                       Monthly Qty  Unit   Monthly Cost 
                                                                                             
 aws_db_instance.rds                                                                         
 ├─ Database instance (on-demand, Single-AZ, db.t4g.micro)          730  hours        $12.41 
 └─ Storage (general purpose SSD, gp2)                               10  GB            $1.27 
                                                                                             
 aws_elasticache_cluster.redis                                                               
 └─ ElastiCache (on-demand, cache.t4g.micro)                        730  hours        $12.41 
                                                                                             
 aws_instance.checkly                                                                        
 ├─ Instance usage (Linux/UNIX, on-demand, t3.nano)                 730  hours         $4.16 
 └─ root_block_device                                                                        
    └─ Storage (general purpose SSD, gp2)                            10  GB            $1.10 
                                                                                             
 aws_instance.webserver                                                                      
 ├─ Instance usage (Linux/UNIX, on-demand, t4g.nano)                730  hours         $3.36 
 └─ root_block_device                                                                        
    └─ Storage (general purpose SSD, gp2)                            10  GB            $1.10 
                                                                                             
 OVERALL TOTAL                                                                        $35.81 
──────────────────────────────────
24 cloud resources were detected:
∙ 4 were estimated, all of which include usage-based costs, see https://infracost.io/usage-file
∙ 20 were free:
  ∙ 7 x aws_security_group_rule
  ∙ 3 x aws_security_group
  ∙ 2 x aws_subnet
  ∙ 1 x aws_db_subnet_group
  ∙ 1 x aws_elasticache_subnet_group
  ∙ 1 x aws_internet_gateway
  ∙ 1 x aws_key_pair
  ∙ 1 x aws_route
  ∙ 1 x aws_route_table
  ∙ 1 x aws_route_table_association
  ∙ 1 x aws_vpc
```

### Infrastructure diagram
Diagram generated using Pluralith

![alt text](https://github.com/gordonmurray/terraform_aws_checkly_private_location/blob/main/files/pluralith-local-project.png?raw=true)