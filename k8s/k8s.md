# Kubernetes

## Running a Kubernetes YAML File in minikube cluster

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

4. **Apply the YAML File**:
    Navigate to the directory containing the Kubernetes YAML file and apply it using `kubectl`:
    ```sh
    kubectl apply -f k8s/local/frontend-local.yaml
    ```

5. **Verify Deployment**:
    Check the status of your deployment to ensure everything is running correctly:
    ```sh
    kubectl get pods
    kubectl get services
    ```

6. **Access Your Application**:
    If your application is exposed via a service, you can access it using the Minikube IP and the service port:
    ```sh
    minikube service <service-name>
    ```

Replace `<service-name>` with the name of your service obtained from `kubectl get services`.

## Running a Kubernetes YAML in the cloud

WIP