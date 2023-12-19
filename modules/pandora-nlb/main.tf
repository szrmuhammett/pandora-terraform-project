resource "aws_lb" "my_nlb" {
  name               = "my-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [var.subnet_id]  # Update with your subnet ID(s)
}

resource "aws_lb_target_group" "my_nlb_target_group" {
  name     = "my-nlb-target-group"
  port     = 80
  protocol = "TCP"

  health_check {
    enabled = false
  }
}

resource "aws_lb_listener" "my_nlb_listener" {
  load_balancer_arn = aws_lb.my_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.my_nlb_target_group.arn
    type             = "forward"
  }
}