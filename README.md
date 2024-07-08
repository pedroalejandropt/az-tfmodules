# az-tfmodules

## Overview
**az-tfmodules** is a repository containing Terraform modules designed for managing resources on Azure Cloud. These modules help streamline the infrastructure as code process for Azure environments, providing reusable and customizable components.

## Repository Structure
- **infra**: Contains infrastructure-related configuration files.
    - **applications**: Each application is built and configured here. Applications must be declared in `main.tf` to be created in azure.
    - **modules**: Each azure resource is created as a module, allowing each application to use them or not in case it needs them.
    - **variables**: `*.tfvars` files contains versions or paramaters that should be use by the applications or providers.
- **nuxt-boilerplate**: Boilerplate code for Nuxt.js, integrated with Nginx for frontend development.
    - **Dockerfile**: Constains the structure to build the nuxt image integrated with nginx.
    - **docker-compose**: This files create the image and start it, using a simple command line.
- **application.yml**: A simple application (deployments, services, ingress, ...) setup by YAML file.

## Azure Resources
The repository supports creating a variety of Azure resources, including but not limited to:
- Virtual Networks
- Subnets
- Network Security Groups
- Virtual Machines
- Storage Accounts
- Azure Kubernetes Service (AKS)
- Azure Container Registry (ACR)
- Managed Databases (e.g., Azure SQL, Cosmos DB)
- Application Gateways
- Load Balancers
- Work in progress (WIP)

## Usage
1. Clone the repository:
    ```sh
    git clone https://github.com/pedroalejandropt/az-tfmodules.git
    cd az-tfmodules
    ```

2. Navigate to the desired module directory and follow the module-specific instructions.

3. Deploy the infrastructure:
    ```sh
    terraform init
    terraform plan
    terraform apply
    terraform destroy
    ```
    It is possible to specify the `*.tfvars` file with the environment config.
    ```sh
    terraform init
    terraform plan -var-file="./variables/local.tfvars"
    terraform apply -var-file="./variables/local.tfvars"
    terraform destroy -var-file="./variables/local.tfvars"
    ```

## Nuxt.js Integration with Nginx
The `nuxt-boilerplate` directory includes a Nuxt.js application configured to run behind an Nginx server. This setup provides a robust, production-ready frontend application.

## Building and Deploying Docker Images
To build and upload a Docker image to Azure Container Registry (ACR):
1. Build the Docker image:
    ```sh
    docker build -t <acr_name>.azurecr.io/<image_name>:<tag> .
    ```

2. Log in to ACR:
    ```sh
    az acr login --name <acr_name>
    ```

3. Push the image to ACR:
    ```sh
    docker push <acr_name>.azurecr.io/<image_name>:<tag>
    ```
Alternative to build and push the docker image:
1. Using the following command:
    ```sh
    docker buildx build --platform linux/amd64 -t <acr_name>.azurecr.io/<image_name>:<tag> --push .
    ```

## Creating Resources in AKS Using YAML
To deploy resources to an Azure Kubernetes Service (AKS) cluster using a YAML file:
1. Connect to your AKS cluster:
    ```sh
    az aks get-credentials --resource-group <resource_group> --name <cluster_name>
    ```

2. Apply the YAML configuration:
    ```sh
    kubectl apply -f <resource_file>.yaml
    ```

3. Rollback the YAML configuration (Delete the resources):
    ```sh
    kubectl delete -f <resource_file>.yaml
    ```

### Important
    
- Before create the resources into the AKS cluster is important install a dependecy to use the ingress feature of nginx (just for nginx applications). This is an one time operation.

    ```sh
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
    ```

## Monitoring
Deploy resources to monitoring the cluster in Azure Kubernetes Service (AKS). This is an one time operation.
* Use the following commands, install helm if necessary `brew install helm` or [here](https://helm.sh/docs/intro/install/):
    ```sh
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
    ```
* List of the most useful dashboards:

    1. Kubernetes / Networking / Cluster
    2. Kubernetes / Networking / Namespace (Pods)
    3. Kubernetes / Networking / Pod
    4. Kubernetes / Persistent Volumes
    5. **User could create their own dashboards**

## Boilerplate Application Diagram

![app diagram](https://github.com/pedroalejandropt/az-tfmodules/blob/main/docs/application-infra.png?raw=true)


## License
This project is licensed under the MIT License.
