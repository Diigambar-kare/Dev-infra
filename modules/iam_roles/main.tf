resource "aws_iam_role" "dev_ecs_task_role" {
  name = "dev-ecsTaskRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "dev_ecs_task_role_policy" {
  name        = "dev-ecsTaskRolePolicy"
  description = "Policy for ECS Task Role"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "SecretsManagerAccessForMySqlDb"
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = "arn:aws:secretsmanager:ap-south-2:182399696098:secret:fittbot/mysqldb-gOhESB"
      },
      {
        Sid      = "SecretsManagerAccessForSessionToken"
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = "arn:aws:secretsmanager:ap-south-2:182399696098:secret:fittbot/sessiontoken*"
      },
      {
        Sid      = "SecretsManagerAccessForOTPSecrets"
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = "arn:aws:secretsmanager:ap-south-2:182399696098:secret:fittbot/otpsecrets*"
      },
      {
        Sid      = "KMSUnrestrictedAccess"
        Effect   = "Allow"
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid      = "S3Access"
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::fittbot-uploads/*"
      },
      {
        Sid      = "ECSAndECRAccess"
        Effect   = "Allow"
        Action   = [
          "ecs:RunTask",
          "ecs:DescribeTasks",
          "ecs:ListTasks",
          "ecs:DescribeClusters",
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "*"
      },
      {
        Sid      = "ElasticFileSystemAccess"
        Effect   = "Allow"
        Action   = "elasticfilesystem:ClientMount"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dev_ecs_task_role_attachment" {
  role       = aws_iam_role.dev_ecs_task_role.name
  policy_arn = aws_iam_policy.dev_ecs_task_role_policy.arn
}

resource "aws_iam_role" "dev_ecs_task_execution_role" {
  name = "dev-ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.dev_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecs_execution_custom_policy" {
  name        = "ecs-execution-custom-policy"
  description = "Additional permissions for ECS Task Execution Role"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "iam:PassRole"
      Resource = "arn:aws:iam::182399696098:role/ecsTaskExecutionRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_custom_policy_attachment" {
  role       = aws_iam_role.dev_ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_execution_custom_policy.arn
}

resource "aws_iam_role" "dev_code_deploy_ecs" {
  name = "dev-code-deploy-ecs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "code_deploy_full_access" {
  role       = aws_iam_role.dev_code_deploy_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_full_access" {
  role       = aws_iam_role.dev_code_deploy_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "code_deploy_role_for_ecs" {
  role       = aws_iam_role.dev_code_deploy_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_policy" "code_deploy_custom_policy" {
  name        = "code-deploy-custom-policy"
  description = "Custom policy for CodeDeploy ECS role"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ecs:DescribeServices",
        "ecs:ListClusters",
        "ecs:ListServices",
        "codedeploy:GetDeploymentGroup"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "code_deploy_custom_policy_attachment" {
  role       = aws_iam_role.dev_code_deploy_ecs.name
  policy_arn = aws_iam_policy.code_deploy_custom_policy.arn
}
