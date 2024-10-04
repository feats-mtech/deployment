# Kubernetes

## Running Kubernetes on DigitalOcean

### Prerequisites
- Install [doctl](https://docs.digitalocean.com/reference/doctl/how-to/install/) (official DigitalOcean CLI)
- DigitalOcean Kubernetes cluster created
- DigitalOcean container registry created and linked to Kubernetes cluster

### Setup

This section is still WIP

#### Install an ingress controller

DigitalOcean Kubernetes doesn’t automatically install an Ingress Controller, so you’ll need to install one. NGINX Ingress Controller is a common choice:

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml`

This will install the NGINX Ingress Controller in your cluster, which handles routing traffic from the outside world into your cluster.


verify deployment by running:
`kubectl get pods -n ingress-nginx`

check service type for ingress controller:
`kubectl get svc -n ingress-nginx`

If the **EXTERNAL-IP** is `<pending>`, it means the external IP is being provisioned, which may take a few minutes.


#### Firewall settings

We need to add inbound rules to the existing firewall meant for public access. Add HTTP and HTTPS inbound rules to the firewall within the kubernetes cluster. View the firewall settings [here](https://cloud.digitalocean.com/networking/firewalls)


## Running Kubernetes on Minikube

To run a Kubernetes YAML file for local testing purposes, follow these steps:

1. **Install Kubernetes CLI (kubectl)**:
    Ensure you have `kubectl` installed on your machine. You can install it by following the instructions [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/).  
    
2. **Set Up Kubernetes Cluster**:
    Make sure you have a running Kubernetes cluster. You can use Minikube for a local cluster. Install Minikube by following the instructions [here](https://minikube.sigs.k8s.io/docs/start/).

3. **Start Minikube**:
    Start your Minikube cluster with the following command:
    ```sh
    minikube start
    ```

4. **Building your Docker images**
    If you built your images locally, you need to load it into Minikube:
    ```sh
    eval $(minikube docker-env)               # Point to Minikube's Docker daemon
    cd /projects/frontend                     # Go to your project root folder
    docker build -t feats-frontend:latest .   # Build the image locally
    ```

5. **Apply the YAML File**:
    Navigate to the directory containing the Kubernetes YAML file and apply it using `kubectl`:
    ```sh
    kubectl apply -f k8s/local/frontend-local.yaml
    ```

6. **Verify Deployment**:
    Check the status of your deployment to ensure everything is running correctly:
    ```sh
    kubectl get pods
    kubectl get services
    ```

7. **Access Your Application**:
    If your application is exposed via a service, you can access it using the Minikube IP and the service port:
    ```sh
    minikube service <service-name>
    ```

Replace `<service-name>` with the name of your service obtained from `kubectl get services`.
