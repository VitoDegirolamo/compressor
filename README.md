# compressor

## _I describe my experience_

To accomplish assestment exercise I've done the following steps.

## Steps

### Stage 1 - Development environment

* Cloned git repo as suggested;
* I created a Dockerfile to create app's image and tested it with docker run (you'll find it in the root folder)
   * 1st step: build and serve app directly
```sh
docker build . -t compressor
docker run -p 3000:3000 --name compressor --rm compressor
```
   * 2nd step: add nginx conf to serve app as requested
```sh
docker build . -t compressor
docker run -p 80:80 --name compressor --rm compressor
```
* I created docker-compose and test it with docker-compose up (you'll find it in the root folder)
```sh
docker-compose up -d
```
### Stage 2 - Kubernetes resources

* I convert docker-compose in kubernetes resources (you'll find it in resources folder):
   * deployment.yaml: describe the deployment resource
   * service.yaml: describe the service resource
* I tested this resources with minikube:
   * I installed minikube on my local machine:
```sh
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
```
  * I turned on cluster:
```sh
minikube start
```
   * I shared cluster registry with my host's registry with:
```sh
eval $(minikube -p minikube docker-env)
```
   * I created an alias to work with kubectl command:
```sh
alias kubectl="minikube kubectl --"
```
   * I started dashboard that helped me to see and analyze cluster information (in addition to kubectl command)
```sh
minikube dashboard
```
   * I deployed resources with:
```sh
kubectl apply -f <resource_name>
```
   * After some fix I tested the correct conf with kubectl port-forward command against deployment before and service later (no ingress was required):
```sh
kubectl port-forward <type>/<name> <host_port>:<container_port>
```
### Stage 3 - Deployment to production
* I created Terraform's files (you'll find it in infrastructure folder):
   * provider.tf: sample file to configure AWS provider;
   * ecr_registry.tf: a descriptor file to create a repository on ECR and push builded image
   * codebuild.tf: a descriptor file to create a codebuild project on AWS Codebuild called "compressor_codebuild_project" 
* Finally I was on last step: create and test a buildspec.yml file to build the app and create artifact (you'll find in the root folder):
   * I've created file and writed build step in order to compile the web application
   * In the meantime I follow instruction to install Codebuild service locally:
      * I cloned aws repo in a different folder and built image:
      * I pulled amazon/aws-codebuild-local:latest image
      * I downloaded codebuild_build.sh script to execute build step (you'll find it in the root 
      * I ran build script and it produced in the out folder artifacts.zip (at first shot!)
```sh
# In a different folder
git clone https://github.com/aws/aws-codebuild-docker-images.git
cd aws-codebuild-docker-images/ubuntu/standard/5.0/
docker build -t aws/codebuild/standard:5.0 .
docker pull amazon/aws-codebuild-local:latest --disable-content-trust=false
# In project folder
wget https://raw.githubusercontent.com/aws/aws-codebuild-docker-images/master/local_builds/codebuild_build.sh
chmod +x codebuild_build.sh
./codebuild_build.sh -i aws/codebuild/standard:5.0 -a ./out
```
* Last: I set in codebuild.tf the policy (I think) is needed to build and deploy project 

Conclusion:

I have encountered new technologies in this exercise.
This excite me because I was enforced to study new stuff and I love that.
The technologies that I never used was:

* React: I never built an app with this (but I used similar e.g.: angular)
* Kubernetes: I study a lot about this orchestrator but I never had occasion to work with
* Terraform: I am very curious about IaaC and this has been a good opportunity to start a study session
* AWS Codebuild: I have seen different AWS services (ECR/ECS/EC2/Fargate/S3) and this one missed me

I dedicated a few hours to accomplish the assestment and I want to thank you for your attention and for the challenge!

## Author
Vito Degirolamo
DevOps Team Leader
LinkedIn: [Vito Degirolamo](https://www.linkedin.com/in/vito-degirolamo-46823680/)
