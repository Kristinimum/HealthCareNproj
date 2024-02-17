provider "aws" {
  region = "us-east-1" # Specify your desired AWS region
}

resource "aws_codebuild_project" "my_project" {
  name       = "my-codebuild-project"
  description= "My CodeBuild Project"
  
  service_role = aws_iam_role.CodeBuildServiceRole.arn
  
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
    buildspec = "buildspec.yml"    #doublecheck referencing correct buildspec file
  }

  tags = {
    Name = "my-codebuild-project"
  }
}

resource "aws_iam_role" "CodeBuildServiceRole" {
  name               = "CodeBuildServiceRole"
  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
	    "Statement": [
		{
			"Action": [
				"s3:*",
				"cloudfront:CreateInvalidation",
				"codebuild:StartBuild",
				"codebuild:BatchGetBuilds",
				"logs:CreateLogGroup",
				"logs:CreateLogStream",
				"logs:PutLogEvents",
				"ssm:CreateAssociation",
				"ssm:CreateAssociationBatch",
				"ssm:UpdateAssociation",
				"ssm:UpdateAssociationStatus",
				"codecommit:GetBranch",
				"codecommit:GetCommit",
				"codecommit:UploadArchive"
			],
			"Resource": "*",
			"Effect": "Allow"
      Principal = {                           #I'm not sure if we need lines 60-63    
        Service = "codebuild.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
		}
	]
}

  // Attach policies as needed
 
}