
resource "aws_ecs_cluster" "main" {
  name = "drupal-cluster"
}

resource "aws_ecs_service" "drupal_service" {
  name            = "drupal-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.drupal.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public.id, aws_subnet.public_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.drupal_tg.arn
    container_name   = "drupal"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http]
}
