# launch template - IMDSv2 enforced, gp3 encrypted root volume
resource "aws_launch_template" "eks_nodes" {
  name_prefix = "${var.name_prefix}-eks-nodes-"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"  # IMDSv2 only, no v1
    http_put_response_hop_limit = 2
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.node_disk_size
      volume_type = "gp3"
      encrypted   = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.name_prefix}-eks-node"
    })
  }

  tags = var.common_tags
}
