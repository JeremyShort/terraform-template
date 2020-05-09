#####
# Roles and policies to give the jenkins host permission to backup things to S3
# and read credstash secrets
#####

resource "aws_iam_role" "jenkins-role" {
  name        = "jenkins-instance-role-${var.env}"
  description = "IAM Role for jenkins instance"

  tags = {
    Name            = "jenkins-instance-role-${var.env}"
    owner           = "cloudops-admin@semanticbits.com"
    pagerduty-email = "qpp-claims-devops@semanticbits.com"
    application     = "jenkins"
    env             = "${var.env}"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "ecs-tasks.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#### Credstash read policy

data "aws_caller_identity" "current" {}

data "template_file" "credstash-read-policy-jenkins" {
  template = file("templates/credstashIAMPolicy.tpl")

  vars = {
    awsAccountId = data.aws_caller_identity.current.account_id
    kmsKeyId     = var.credstash_kms_key_id
  }
}

resource "aws_iam_policy" "jenkins-credstash-read-policy" {
  name        = "jenkins-credstash-read-policy-${var.env}"
  description = "A policy to allow the webserver to read items from Credstash."
  policy      = data.template_file.credstash-read-policy-jenkins.rendered
}

data "template_file" "iam-policy-jenkins" {
  template = file("templates/iam_policy.tpl")
}

#### ECS Policy

data "template_file" "jenkins-ecs-policy" {
  template = file("templates/ecs_policy.tpl")
}
## TODO: Need rebuild so Jenkins master & Slaves have separate Roles
resource "aws_iam_policy" "iam-policy-jenkins" {
  name        = "jenkins-iam-policy-"
  description = "A policy to allow jenkins and slaves to use services"
  policy      = data.template_file.iam-policy-jenkins.rendered
}

resource "aws_iam_policy" "jenkins-ecs-policy" {
  name        = "jenkins-ecs-policy-${var.env}"
  description = "A policy to allow the jenkins to deploy ECS services"
  policy      = data.template_file.jenkins-ecs-policy.rendered
}

#### Policy attachments

resource "aws_iam_role_policy_attachment" "jenkins-credstash-policy-attachment" {
  policy_arn = aws_iam_policy.jenkins-credstash-read-policy.arn
  role       = aws_iam_role.jenkins-role.name
}

resource "aws_iam_instance_profile" "jenkins-profile" {
  name = "jenkins-profile-${var.env}"
  role = aws_iam_role.jenkins-role.name
}

resource "aws_iam_policy_attachment" "jenkins-iam-policy-attachment" {
  name       = "jenkins-iam-policy-attachment-${var.env}"
  roles      = [aws_iam_role.jenkins-role.name, aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.iam-policy-jenkins.arn
}

resource "aws_iam_policy_attachment" "jenkins-policy-ecs-attachment" {
  name       = "jenkins-policy-ecs-attachment-${var.env}"
  roles      = [aws_iam_role.jenkins-role.name, aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.jenkins-ecs-policy.arn
}

# Managed IAM policy for AmazonSESFullAccess
resource "aws_iam_role_policy_attachment" "ses-full-access_policy_attachment" {
  role       = aws_iam_role.jenkins-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

# Permissions required to use AmazonCloudWatchAgent on servers
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {
  role       = aws_iam_role.jenkins-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Managed IAM Policy for Jenkins role for SSM
resource "aws_iam_role_policy_attachment" "jenkins_ssm_policy" {
  role       = aws_iam_role.jenkins-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

