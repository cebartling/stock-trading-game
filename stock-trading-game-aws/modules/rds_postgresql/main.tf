##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "default" {
  default = true
}

//data "aws_subnet_ids" "all" {
//  vpc_id = "${data.aws_vpc.default.id}"
//}

resource "aws_security_group" "horsingaround_db" {
  name        = "horsingaround_db"
  description = "RDS postgres servers (terraform-managed)"
  vpc_id      = "${data.aws_vpc.default.id}"

  # Only postgres traffic in
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "horsingaround_db" {
  allocated_storage       = 20 # gigabytes
  backup_retention_period = 7  # in days

  //  db_subnet_group_name = "${var.rds_public_subnet_group}"
  engine         = "postgres"
  engine_version = "10.4"
  identifier     = "horsingaround-db"
  instance_class = "db.t2.micro"
  multi_az       = false
  name           = "horsingaround_db"

  //  parameter_group_name = "horsingaround_db_paramgroup1"
  password               = "${trimspace(file("${path.module}/secrets/password.txt"))}"
  port                   = 5432
  publicly_accessible    = true
  storage_encrypted      = false
  storage_type           = "gp2"
  username               = "horsingaround"
  vpc_security_group_ids = ["${aws_security_group.horsingaround_db.id}"]
}
