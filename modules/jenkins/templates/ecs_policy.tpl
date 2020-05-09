{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "ecs:ListAttributes",
        "ecs:UpdateContainerInstancesState",
        "ecs:StartTask",
        "ecs:RegisterContainerInstance",
        "ecs:DescribeTaskDefinition",
        "ecs:DeregisterTaskDefinition",
        "ecs:ListServices",
        "ecs:UpdateService",
        "ecs:CreateService",
        "ecs:RunTask",
        "ecs:ListTasks",
        "ecs:RegisterTaskDefinition",
        "ecs:StopTask",
        "ecs:DescribeServices",
        "ecs:SubmitContainerStateChange",
        "ecs:DescribeContainerInstances",
        "ecs:DeregisterContainerInstance",
        "ecs:DescribeTasks",
        "ecs:ListTaskDefinitions",
        "ecs:ListClusters",
        "ecs:SubmitTaskStateChange",
        "ecs:DescribeClusters",
        "ecs:ListTaskDefinitionFamilies",
        "ecs:UpdateContainerAgent",
        "ecs:ListContainerInstances",
        "ecs:DeleteService"
      ],
      "Resource": "*"
    },
    {
      "Sid": "VisualEditor2",
      "Effect": "Allow",
      "Action": [
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:PutRolePolicy"
      ],
      "Resource": "*"
    }
  ]
}