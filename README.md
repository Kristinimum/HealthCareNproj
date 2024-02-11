# HealthCareNproj
Code repo for Pod2 project
## Introduction
Team Pod2 Consulting has been tasked with assisting HealthCare North, a regional hospital with transitioning their website to a more reliable, cost-effective, and secure website hosting solution in the cloud. The transition will involve moving the hospitals static website from an AWS EC2 instance to an AWS S3 static website. Sound DevOps practices, along with a CI/CD pipeline, and use of Terraform for Infrastructure as Code will be employed to use proper testing mechanisms to minimize issues with the website. Proper documentation will be provided for ease of management of the hospital's cloud environment.
The website is critical to HealthCare North's business as the first point of contact for patients and ongoing communication with their caretakers at HealthCare North.
Modernizing HealthCare North's website infrastructure will reduce operational cost, enhance website reliability, and improve security. This improved reliability will be passed on their patients using the website which is critical for providing healthcare to all patients. Improving this infrastructure allows potential to scale digital assets in the future and continue with good DevOps practices.
## Solution Tasks
-Configure S3 Static Website.
-Use AWS CloudFront as a CDN to deliver the website securely over HTTPS.
-Create a CI/CD pipeline for deployment automation so website changes go through proper channels before going live.
-Use Development and Production environments to test website changes. Each environment will be S3 Bucket. All changes will be tested in the Development environment first. 
-To ensure updates won't disrupt site functionality, unit tests in the CI/CD pipeline will be used to verify that key components of website work correctly.
-Manual approval for Production environment in the CI/CD pipeline will be used so authorization is needed before deploying to the Production environment.
-Infrastructure Management will be with Terraform. This will define and deploy all resources. This method also provides documentation as well as the ability to recreate the infrastructure should the need arise. 

## Branching Strategy
GitHub Flow is the branching strategy for this project. The main branch contains the production-ready code. Feature branches will be created and used for developing code. Once a Developer is ready to push code to the main branch, they will use a pull request. The user will ask one of the other contributors to review the pull request. Once the other contribuotr confirms the new features are ready to be merged with the main branch they will approve the pull request. The creator of the feature branch can then delete to feature branch. 