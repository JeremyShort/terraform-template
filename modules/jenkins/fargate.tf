resource "aws_ecs_cluster" "jenkins" {
  name = "jenkins-fargate-cluster"
}

resource "aws_ecs_task_definition" "jenkins-master" {
  family                   = "jenkins"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "2048"
  memory                   = "4096"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = file("templates/jenkins-master-td.json")

}
