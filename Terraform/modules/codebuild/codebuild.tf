provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

resource "aws_codebuild_project" "my_project" {
  name       = "my-codebuild-project"
  description= "My CodeBuild Project"
  
  service_role = aws_iam_role.my_codebuild_role.arn
  
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "1.7.3"
    }
  }

  source {
    type            = "CODEPIPELINE"
  }

  tags = {
    Name = "my-codebuild-project"
  }
}

resource "aws_iam_role" "my_codebuild_role" {
  name               = "my-codebuild-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })

  // Attach policies as needed
 
}
