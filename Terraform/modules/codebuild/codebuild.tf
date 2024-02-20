##############      CODEBUILD RESOURCE BLOCK      ##############
resource "aws_codebuild_project" "my_project" {
  name        = "my-codebuild-project"
  description = "My CodeBuild Project"

  role_arn = "arn:aws:iam::#######:role/CodeBuildServiceRole"

  artifact_store {
    type     = var.artifacts_store_type #This is what Corey had in his codepipeline resource block.
    location = var.s3_bucket_id
  }

  #############     CODEBUILD STAGES BLOCK       ##############

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "1.7.3"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "./Terraform/buildspec.yml" #doublecheck referencing correct buildspec file             
  }                                         # "./templates/buildspec_${var.build_projects[count.index]}.yml" might use this later?

  tags = {
    Name = "my-codebuild-project"
  }
}