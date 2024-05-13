# NextCloud
```
# Deployment

1- Run the refarch toolset docker image:

docker run -it -v PATH_TO_WORKDIR:/home/refarch -v PATH_TO_PRIVATE_KEY:/root/.ssh/id_rsa:ro git.sztaki.hu:5050/science-cloud/reference-architectures/refarch-toolset bash

-In place of 'PATH_TO_WORKDIR', the path to your working directory must be set >> This directory will contain the descriptor files.
The mounted working directory will be the entrypoint of the container.


-In place of 'PATH_TO_PRIVATE_KEY', the path to the file containing the private part of your configured SSH key must be set.
The private key file is mounted with the read-only option.


2- Enter the directory of OpenStack descriptors:

cd /home/refarch/terraform_openstack

Customize resources.auto.tfvars to your needs.


3- Source the credential information:

An application credential and your authentication URL is needed to enable Terraform to access your resources
You can create an application credential on the OpenStack web interface under Identity > Application Credentials. 
After the application credential is generated, download the openrc file and source it with the following command: source app-cred-openrc


4- Provisioning the reference architecture:

terraform init
terraform apply -auto-approve && cd ../ansible && ansible-playbook -i hosts.yml deploy_nextcloud.yml

6- (Optional) Terminating the reference architecture:

terraform destroy
