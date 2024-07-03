# Web Server Deployment with Rancher Fleet

This repository contains the necessary resources to deploy a web server that serves a default page using a ConfigMap. The deployment uses Rancher Fleet for continuous delivery.

## Files

- `fleet.yaml`: Fleet configuration file.
- `1_configmap.yaml`: Defines the ConfigMap containing the default HTML page.
- `2_deployment.yaml`: Defines the Deployment of the web server.
- `3_service.yaml`: Defines the NodePort Service to expose the web server.

## Prerequisites

- Kubernetes cluster managed by Rancher 2.8

## 1. Deploy via Rancher 2.8 UI

### Log in to Rancher 2.8:
Open your Rancher 2.8 UI in your browser and log in.

### Navigate to Fleet:
From the left-hand menu, click on `Continuous Delivery`

### Create a New GitRepo:
- Click on `Git Repos` and then `Create`.
- Fill in the details:
  - **Name**: `step4`
  - **Repository URL**: `[https://github.com/rancherlabs/cfl-summit-lab]`
  - **Branch**: `main` (or the branch you want to deploy from)
  - **Paths**: Leave as default to deploy all resources, or specify paths if needed.

### Set the Target Clusters:
- In the `Targets` section, specify the clusters where you want the resources to be deployed. You can use labels to select clusters, e.g., `environment: dev`.

### Create the GitRepo:
- Click on `Create` to save and deploy the resources.

Fleet will automatically sync the repository and deploy the resources to the specified clusters.

## 2. Verify the Deployment

### Check the Pods:
Navigate to the `Workloads` section in Rancher UI and ensure that the `webserver` pod is running.

### Check the Service:
Navigate to the `Services` section and ensure that the `webserver-service` is created and exposing the NodePort.

### Access the Web Server:
Open a web browser and access the web server using the NodePort. For example, `http://<NodeIP>:30080`.

## 3. Bonus Exercise: Modify ConfigMap and Observe Fleet

### Modify the ConfigMap via Rancher 2.8 UI:
1. **Navigate to Config Maps**:
   - From the left-hand menu, click on `Config Maps` under the `Resources` section.
   - Select the `web-content` ConfigMap.

2. **Edit the ConfigMap**:
   - Click on `⋮` (the three dots) next to the `web-content` ConfigMap and select `Edit`.
   - Modify the `index.html` data to update the content:
    ```html
    <!DOCTYPE html>
    <html>
    <head>
      <title>Updated Page</title>
    </head>
    <body>
      <h1>Welcome to the Updated Page</h1>
      <p>This page has been updated.</p>
    </body>
    </html>
    ```

3. **Save Changes**:
   - Click on `Save` to apply the changes.

### Observe the Change:
1. Fleet will detect the change in the ConfigMap and show a missing resource on the `Continuous Delivery` Dashboard.
2. You may need to redploy the pods by accessing the Workloads, deployments and then selecting redeploy. (or delete the pod)
3. Verify the change by accessing the web server again. The page should now display the updated content.

### Revert the Changes:
1. To revert the changes, Goto the `Continuous Delivery` Fleet dashboard and select `Force Update` on the `step4` repo.

2. Fleet will redeploy the original ConfigMap, reverting the web page to its initial state.

### Auto-Healing Feature:
- Fleet has an auto-healing feature that ensures the deployed resources match the desired state defined in the Git repository. If any changes are made directly in the cluster (e.g., someone manually edits the ConfigMap in the cluster), Fleet will automatically revert those changes to match the state defined in the repository.
- This feature enforces consistency and prevents configuration drift, ensuring that the cluster's state is always as defined in the version-controlled repository.

## Troubleshooting

- If the Deployment is in `CrashLoopBackOff`, check the logs of the pod for errors.
- Ensure that the ConfigMap is correctly mounted and the file paths are correct.

## Conclusion

By following the steps in this guide, you will have deployed a web server using Rancher Fleet and observed how changes are managed and auto-healed. For any issues, please open an issue in this repository or refer to the Rancher documentation.
