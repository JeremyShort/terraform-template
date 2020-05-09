Goal of this project is to create a generic infrastructure for deploying web based applications to AWS using Terraform to control the infrastructure. 

# MVP1 is Jenkins Fargate task
# $JENKINS_HOME on EFS
#An ALB to route the Jenkins traffic.

We will have 4 environments by default, controlled by Terraform Workspaces
- Tools - For one off things like the Jenkins server
- Dev - Development branch, things will be down a lot here
- Imp - Integration testing. If something is down here it breaks the deployment process
- Prd - Production environment

 The goal here is to have as much of our infrastructure to be dynamic as possible whilehaving a reliable last known good for each teir or service.

Currently broken: Need to change the task definitions to templates so we can parameterize the data.aws_caller_identity.current.account_id

# Prepreqs:
 - Must have the back end bucket already - versioning enabled!
 - Must have admin access to AWS CLI

Future Features:
- SSM Parameter Store
- Jenkins Fargate with EFS share
- ECR Repo
- Example webservice fargate deployment
- Universal Tagging
- Dashboarding
 - Performance (SLOs, capacity predictions)
 - Health (SLOs, Error rates)
 - Cost (Per Service, Predictive)
 - Tagging based on Service/Environment/?commit?

TODO: Create trello board so others can contribute

# IAM
ECS Task Execution Role - Rights the ECS task has while running

