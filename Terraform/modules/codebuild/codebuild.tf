##############      CODEBUILD RESOURCE BLOCK      ##############
resource "aws_codebuild_project" "my_project" {
  name        = "my-codebuild-project"
  description = "My CodeBuild Project"
  service_role = "arn:aws:iam::654654434704:role/CodeBuildServiceRole"

  artifacts {
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
    buildspec = "./Terraform/files/buildspec.yml" #doublecheck referencing correct buildspec file             
  }                                         # "./templates/files/buildspec_${var.build_projects[count.index]}.yml" might use this later?

  tags = {
    Name = "my-codebuild-project"
  }
}