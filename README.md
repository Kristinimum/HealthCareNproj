# HealthCareNproj
Code repo for Pod2 project
## Introduction
Team Pod2 Consulting has been tasked with assisting HealthCare North, a regional hospital with transitioning their website to a more reliable, cost-effective, and secure website hosting solution in the cloud. The transition will involve moving the hospitals static website from an AWS EC2 instance to an AWS S3 static website. Sound DevOps practices, along with a CI/CD pipeline, and use of Terraform for Infrastructure as Code will be employed to use proper testing mechanisms to minimize issues with the website. Proper documentation will be provided for ease of management of the hospital's cloud environment.
The website is crucial to HealthCare North's business as the first point of contact for patients and ongoing communication with their caretakers at HealthCare North.
Modernizing HealthCare North's website infrastructure will reduce operational cost, enhance website reliability, and improve security. This improved reliability will be passed on to their patients using the website which is crucial for providing healthcare information to all patients. Improving this infrastructure allows the potential to scale digital assets in the future and embrace good DevOps practices.
## Solution Tasks
-Configure S3 Static Website.
-Use AWS CloudFront as a CDN to deliver the website securely over HTTPS.
-Create a CI/CD pipeline for deployment automation so website changes go through proper channels before going live.
-Use Development and Production environments to test website changes. Each environment will be an S3 Bucket. All changes will be tested in the Development environment first. 
-To ensure updates won't disrupt site functionality, unit tests in the CI/CD pipeline will be used to verify that key components of website work correctly.
-Manual approval for Production environment in the CI/CD pipeline will be used so authorization is needed before deploying to the Production environment.
-Infrastructure Management will be with Terraform. This will define and deploy all resources. This method also provides documentation as well as the ability to recreate the infrastructure should the need arise. 

## Branching Strategy
GitHub Flow is the branching strategy for this project. The main branch contains the production-ready code. Feature branches will be created and used for developing code. To create a new branch type, 'git checkout -b <name-of-branch-feature-story-number>'. This will create a new branch and switch to the working branch to make code revisions. By creating a branch, you create a space to work without affecting the main branch. Once a Developer is ready to push code to the main branch, they will use a pull request and follow the pull request template in the text window on GitHub. The user will ask one of the other contributors to review the pull request. Once the other contributor confirms the new features are ready to be merged with the main branch, they will approve the pull request. The creator of the feature branch can then delete the feature branch and then confirm the main branch is up to date with 'git status'. 

## Pull Request Workflow
Prior to working on code in local terminal, run 'git pull' to make sure your branch is up to date. 'git status' can also be used to verify the status of the main branch being up to date. Commit changes to the HealthCareNproj repository from your terminal, then from GitHub make a merge pull request and select a contributor from the list to the right. Ideally select, the team mate that is also working on the story from the Trello board to review your request. Once they approve of the request, they can delete the feature branch. Or if the team mate is not available, then can ask any contributor to review. Once they approve of the request, they can delete the feature branch. The developer that submitted the request can then refresh the main branch in their terminal. 

## Set up environment, install Terraform CLI, AWS CLI, VS Code Editor and Terraform plugin Editor
Here is the link to an install video for all operating systems
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
here is the linkn to download Terraform for your operating system
https://developer.hashicorp.com/terraform/install

To test if terraform installed correctly, open your terminal and if on Windows,type: 'terraform -help'. If on Mac or Linux, type: 'echo $PATH'.
If installed correctly it will show a list of terraform commands or in the case of Mac or Linux will show the location of the terraform download.

Follow the steps in this link to download the latest AWS CLI
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

## Remote Backend in Terraform
The initial main.tf that sets the S3 backend in a bucket named "pod2-hcn-2024."
The DynamoDB table "tfstate-lock-dynamo" is set for locking. This protects Terraform state from having more than one contributor making conflicting changes at one time.

No profile or shared credentials are included in the provider or backend blocks, so each user will need to have their temp access key, secret key, and session token in their default config profile in their local ~/.aws/credentials file in order to run Terraform for the customer's AWS account.

'''

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }

  backend "s3" {

    encrypt        = true
    bucket         = "pod2-hcn-022024"
    key            = "backend/tfstate"
    dynamodb_table = "tfstate-lock-dynamo"
    region         = "us-east-1"

  }
}

provider "aws" {
  region = "us-east-1"
}

'''


