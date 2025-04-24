
resource "aws_ecs_task_definition" "drupal" {
  family                   = "drupal-fargate-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::258185808772:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::258185808772:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([{
    name      = "drupal",
    image     = "drupal:10-apache",
    essential = true,
    portMappings = [{
      containerPort = 80,
      protocol      = "tcp"
    }],
    secrets = [{
      name      = "DRUPAL_DB_PASSWORD",
      valueFrom = "arn:aws:secretsmanager:ap-southeast-1:785028034935:secret:Tet-secret1-TOTfPc"
    }]
  }])
}
