resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [var.subnet_id]  # Update with your subnet ID(s)
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"

  health_check {
    path        = "/"
    port        = "traffic-port"
    interval    = 30
    timeout     = 10
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    type             = "forward"
  }
}

