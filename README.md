# AzureMapsNet6

## Introduction
These are an Azure Maps examples for the different ways to secure Azure Maps.

## Build & Deploy Status
[![Build_and_Deploy](https://github.com/RPagels/AzureMapsNet6/actions/workflows/Build_and_Deploy.yml/badge.svg)](https://github.com/RPagels/AzureMapsNet6/actions/workflows/Build_and_Deploy.yml)

## Azure Maps Authentication Approaches
- Azure Maps Subscription Key only, local machine
- Azure Maps Subscription Key only, Web App using Key Vault
- Azure Maps + GetAzureMapsToken() = Anonymous
- Azure Maps + GetAzureMapsToken() + .net/AAD Authentication = Authentication

## Deploy Resources OR Create them manually
- Create Resource Group in Azure.
- TBD, output will be maps name, app service name, keyvault name

## Azure Maps Account
Azure Maps is a portfolio of geospatial services that include service APIs for Maps, Search, Routing, Traffic and Time Zones. We will be using Azure Maps for visualization of the data in one of the labs. In this section, you will create the Azure Map component so we can use it later.

Use the following steps to create an Azure Map:
- In the Azure portal click **+Create a resource** at the top left of the screen.
- In the **Search the Marketplace** textbox, type **Azure Maps** and press **Enter**.

    ![Image](/images/maps-image1.png)

- Select **Maps** from the list.

    ![Image](/images/maps-image2.png)

- Click **Create** to create a Maps Account.

- Fill in the fields.

    - **Subscription**, select the subscription to use for your Azure Maps Account.
    - **Resource Group**, choose the one created already, i.e. **rg-<*lastname*>-azuremaps**.
    - **Name**, type in the name for your Azure Maps Account. This name must be globally unique.
        - Type **<*lastname*>-azuremaps**.
    - **Pricing Tier**, select **Standard S0**.

    - Check the box **I confirm...**.

        ![Image](/images/maps-image3.png)

    - Select **Review + Create**, then **Create**.

    > You can watch the notification pane to validate that it created successfully.

- Once deployment is complete, click Go to resource
- Copy the **Client ID** because you will need it in later steps.
- Click **Authentication**.

> there are two methods to authenticate for Azure Maps API calls
- Shared Key Authentication is great for testing and demos, but not recommended for use in Web applications. 
- AAD (Azure Active Directory) Authentication is the recommended approach
  - See [Secure a web application with user sign-in](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-secure-webapp-users)

## Azure App Service
### Settings
- Click on **Identity**.
- Under **Status**, click **On**.
- Under **Permissions**, click **Azure role assignments**.
- Click **+Add role assigment**.
- Under **Scope**, select **Subscription** or **Resource group**, from earlier step.
- Under **Subscription**, select your Azure Subscription.
- Under **Role**, select **Azure Maps Data Reader**.
- Enter **AzureMaps:ClientId** for name.
- Enter **@Microsoft.KeyVault(VaultName=<keyvaultnamehere>;SecretName=ClientId)**. (i.e. kv-m7wwu4af4xh2a)

### Settings
- Click on **Configuration**.
- Under **Application Settings**, click **+New application setting.
- Click **Ok**.

## Azure Key Vault
- coming soon...


## Authentication
- Subscription Key.
  - coming soon...
- Anonymous with Token.
  - coming soon...

### Azure Active Directory
> The recommended approach is to use AAD to secure a web app, [Choose an authentication and authorization scenario](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-manage-authentication#choose-an-authentication-and-authorization-scenario).

  - From the Azure Portal home page, search for **Azure Active Directory**.
  - Click **App registrations**.
  - Click **New registration** and give it a name. (i.e. **AzureMapsNet6**)
  - Click **Register**
  - Copy the **Client ID** because you will need it in later steps.
  - Copy the **Tenant ID** because you will need it in later steps.
  - Click on **Authentication**
  - Click on **+Add a platform**, choose **Web**.
  - Under Redirect URIs, click **Add URI**, enter the wepp app URL. (i.e. **https://app3-m7wwu4af4xh2a.azurewebsites.net**)
  - Under **Implicit grant and hybrid flows**
    - Check **Access tokens (used for implicit flows)**
    - Check **ID tokens (used for implicit and hybrid flows)**
  - Under **Supported account types**
    - Select **Accounts in any organizational directory (Any Azure AD directory - Multitenant)**
  - Click **Save**
  - Select **API permissions**
  - Under **Configured permissions**, click **+Add a permission**.
  - Click **APIs my organization uses**.
  - In the Search box, type **Azure Maps**, then select it.
  - Click **Add permissions**.
  
  ## Azure Maps Service
    - From the Azure Portal home page, search for **Azure Maps Service** name created earlier. (i.e. **maps-m7wwu4af4xh2a**)
    - Click **Access Control (IAM)**.
    - Click **Add a role assignement**.
    - Click **Role**, select **Azure Maps Data Reader**
    - Click **Next**.
    - Under **Assign access to**, click **User, Group, or service principal**.
    - Click **+Select Members**.
    - In the search box, type Azure App Registration name from eariler. (i.e. **AzureMapsNet6**)
    - Under **Select**, click on name.
    - Click **Select**.
    - Click **Review + assign**.
    
> If using IaC (Bicep) to deploy pipeline, Managed Identity is used for each App Service and will have a unique name based on resource group name.
    

## Create the .Net 6.0 Application
- step 1
- step 2
- step 3

## Build and Deployment
- This example uses Biep for Infrastructure as Code.
- step 1
- step 2
- step 3

## Resources
- The project is based on the Example Azure Maps with protected website [Repo by Clemens](https://github.com/cschotte/Maps) | [Blog by Clemens](TBD) |
- [Azure-Portal](https://portal.azure.com/)
- [Use the Azure Maps map control]([https://portal.azure.com/](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-use-map-control)
- [Choose an authentication and authorization scenario]([https://portal.azure.com/](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-manage-authentication#choose-an-authentication-and-authorization-scenario)

    
    
