Web Server Deployment with Rancher Fleet

This repository contains the necessary resources to deploy a web server that serves a default page using a ConfigMap. The deployment uses Rancher Fleet for continuous delivery.
Files

    fleet.yaml: Fleet configuration file.
    1_configmap.yaml: Defines the ConfigMap containing the default HTML page.
    2_deployment.yaml: Defines the Deployment of the web server.
    3_service.yaml: Defines the NodePort Service to expose the web server.

Prerequisites

    Kubernetes cluster managed by Rancher 2.8
    Rancher Fleet configured

1. Deploy via Rancher 2.8 UI

    Log in to Rancher 2.8:
    Open your Rancher 2.8 UI in your browser and log in.

    Navigate to Fleet:
    From the left-hand menu, click on Continuous Delivery and then Fleet.

    Create a New GitRepo:
        Click on Git Repos and then Create.
        Fill in the details:
            Name: webserver-deployment
            Repository URL: https://github.com/yourusername/yourrepository
            Branch: main (or the branch you want to deploy from)
            Paths: Leave as default to deploy all resources, or specify paths if needed.

    Set the Target Clusters:
        In the Targets section, specify the clusters where you want the resources to be deployed. You can use labels to select clusters, e.g., environment: dev.

    Create the GitRepo:
        Click on Create to save and deploy the resources.

Fleet will automatically sync the repository and deploy the resources to the specified clusters.
2. Verify the Deployment

    Check the Pods:
    Navigate to the Workloads section in Rancher UI and ensure that the webserver pod is running.

    Check the Service:
    Navigate to the Services section and ensure that the webserver-service is created and exposing the NodePort.

    Access the Web Server:
    Open a web browser and access the web server using the NodePort. For example, http://<NodeIP>:30080.

Troubleshooting

    If the Deployment is in CrashLoopBackOff, check the logs of the pod for errors.
    Ensure that the ConfigMap is correctly mounted and the file paths are correct.

Conclusion

By following the steps in this guide, you will have deployed a web server using Rancher Fleet. For any issues, please open an issue in this repository or refer to the Rancher documentation.

Feel free to customize the README.md file according to your needs. Let me know if you need further assistance!
