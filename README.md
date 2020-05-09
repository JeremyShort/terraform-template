Goal of this project is to create a generic infrastructure for deploying web based applications to AWS using Terraform to control the infrastructure. 

MVP1 is Jenkins Fargate task, then EFS. The goal here is to have as much of our infrastructure to be dynamic as possible whilehaving a reliable last known good for each teir or service.

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

TODO: Create trello board so others can contribute
