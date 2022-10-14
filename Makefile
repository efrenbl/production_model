SHELL = /bin/sh

AWS_PROFILE=
REGION=
ENV_PREFIX=

SERVICE_NAME=

create-vpc: 
		@echo "🚀 Creating VPC"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-vpc \
		--template-body file://cfn/vpc.yaml \
		--parameters file://cfn/vpc.json > log.txt
		@cat ./log.txt  


create-network: 
		@echo "🚀 Deploy ECS Network"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-network \
		--template-body file://cfn/network.yaml \
		--parameters file://cfn//network.json > log.txt
		@cat ./log.txt   
		

create-cluster: 
		@echo "🚀 Deploy ECS Cluster"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-cluster \
		--template-body file://cfn/cluster.yaml \
		--parameters file://cfn/cluster.json > log.txt
		@cat ./log.txt 


create-security-groups: 
		@echo "🚀 Deploy ECS Security Groups"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-security-groups \
		--template-body file://cfn/security-groups.yaml \
		--parameters file://cfn/security-groups.json > log.txt
		@cat ./log.txt   

create-roles: 
		@echo "🚀 Deploy Roles"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-roles \
		--template-body file://cfn/roles.yaml \
		--parameters file://cfn/roles.json \
		--capabilities CAPABILITY_NAMED_IAM > log.txt
		@cat ./log.txt  

create-service: 
		@echo "🚀 Deploy ECS Service"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-$(SERVICE_NAME)-service \
		--template-body file://cfn/service.yaml \
		--parameters file://cfn/service.json > log.txt
		@cat ./log.txt  

create-pipeline: 
		@echo "🚀 Deploy Pipeline"
		@aws --profile $(AWS_PROFILE) --region $(REGION) \
		cloudformation create-stack --stack-name $(ENV_PREFIX)-$(SERVICE_NAME)-pipeline\
		--template-body file://cfn/pipeline.yaml \
		--parameters file://cfn/pipeline.json > log.txt
		@cat ./log.txt  