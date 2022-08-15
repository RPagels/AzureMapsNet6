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

## Detailed Version of Setup
The Detailed Version are step-by-steps for those new to these environments.  The Deployment Pipeline version below below is intended for a quick setup and requires some familiarity with Azure and pipelines.

## Azure Resource Group
- In a new browser window, sign in to the [Microsoft Azure Portal](https://portal.azure.com/).
- In the Azure portal click **+Create a resource** at the top left of the screen.
- In the **Search the Marketplace** textbox, type **Resource Group** and press **Enter**.
- Select **Resource Group** from the list.

- Click **Create** to create a Resource Group.
- Fill in the fields.

    - **Subscription**, select the subscription to use for your Azure Maps Account.
    - **Resource Group**, choose the one created already, i.e. **rg-<*lastname*>-azuremaps**.
    - **Region**, select **East US**.
    - click **Review + create**.

> Map Accounts are only supported in region: East US, North Europe, West Central US, West Europe, and West US 2

## Azure Maps Account
Azure Maps is a portfolio of geospatial services that include service APIs for Maps, Search, Routing, Traffic and Time Zones. We will be using Azure Maps for visualization of the data in one of the labs. In this section, you will create the Azure Map component so we can use it later.

Use the following steps to create an Azure Map:
- In the Azure portal click **+Create a resource** at the top left of the screen.
- In the **Search the Marketplace** textbox, type **Azure Maps Account** and press **Enter**.

- Select **Maps** from the list.

- Click **Create** to create a Maps Account.

- Fill in the fields.

    - **Subscription**, select the subscription to use for your Azure Maps Account.
    - **Resource Group**, choose the one created already, i.e. **rg-<*lastname*>-azuremaps**.
    - **Region**, select **East US**.
    - **Pricing tier**, select **Gen2**.
    - **Terms**, select checkbox.
    - click **Review + create**.

> Map Accounts are only supported in region: East US, North Europe, West Central US, West Europe, and West US 2.

- Once deployment is complete, click Go to resource

- Click **Authentication**.
- Under **Azure Active Directory Authentication**, copy the **Client ID**, because you will need it in later steps.
- Under **Primary Key**, copy the **SubscriptionKey**, because you will need it in later steps.

> there are two methods to authenticate for Azure Maps API calls
- Shared Key Authentication is great for testing and demos, but not recommended for use in Web applications. 
- AAD (Azure Active Directory) Authentication is the recommended approach
  - See [Secure a web application with user sign-in](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-secure-webapp-users)

> Wait for resrouces to be created.

## Azure App Service

Use the following steps to create an Azure Map:
- In the Azure portal click **+Create a resource** at the top left of the screen.
- In the **Search the Marketplace** textbox, type **WebApp** and press **Enter**.

- Select **Web App** from the list.

- Click **Create** to create a Maps Account.

- Fill in the fields.

    - **Subscription**, select the subscription to use for your Azure Maps Account.
    - **Resource Group**, choose the one created already, i.e. **rg-<*lastname*>-azuremaps**.
    - **Name**, enter a globally unique name. **webapp1-<*lastname*>**.
    - **Publish**, select **Code**.
    - **Runtime stack**, select **.Net6 (LTS)
    - **Operating System**, select **Windows**.
    - **Region**, select **East US**.
    - **App Service Plan**, click **Create New**.
    - **Name**, enter a globally unique name. **webappplan-<*lastname*>**.
    - Under **Monitoring**, click **Create New**.
    - **Name**, enter a globally unique name. **appinsights-<*lastname*>**.
    - **Region**, select **East US**.
    - click **Review + create**.
    
> Wait for resrouces to be created.
    
### App Service Identity
- Click **Go to resource".
- On the App Service Blade, click **Identity**
- Under **Status**, click **On**, click **Save**, click **Yes** for confirmation dialog.
- Under **Permissions**, click **Azure role assignments**.
- Click **+Add role assigment**.
- Under **Scope**, select **Subscription** or **Resource group**, from earlier step.
- Under **Subscription**, select your Azure Subscription.
- Under **Role**, select **Azure Maps Data Reader**.
- Click **Save**.

## Azure Key Vault
Enhance data protection and compliance. Secure key management is essential to protecting data in the cloud. With Azure Key Vault, you can safeguard encryption keys and application secrets like passwords.

Use the following steps to create an Azure Map:
- In the Azure portal click **+Create a resource** at the top left of the screen.
- In the **Search the Marketplace** textbox, type **Key Vault** and press **Enter**.

- Select **Key Vault** from Microsoft from the list.

- Click **Create** to create a Maps Account.

- Fill in the fields.

    - **Subscription**, select the subscription to use for your Azure Maps Account.
    - **Resource Group**, choose the one created already, i.e. **rg-<*lastname*>-azuremaps**.
    - **Name**, enter a globally unique name. **keyvault-<*lastname*>**.
    - **Region**, select **East US**.
    - **Pricing tier**, select **Standard**.
    - click **Review + create**.
    
> Wait for resrouces to be created.
    
### Key Vault Access Policies
- Click **Go to resource".
- On the App Service Blade, click **Access Policies**
- Click **+Add Access Policy**.

- Fill in the fields.

    - **Key Permissions**, check **Get** and **List**.
    - **Secret Permissions**, check **Get** and **List**.
    - **Certificate Permissions**, check **Get** and **List**.
    - **Select Principal**, select the Web App name created earlier. i.e. **webapp1-<*lastname*>**
    - Click **Select**.
 
- Under **Scope**, select **Subscription** or **Resource group**, from earlier step.
- Under **Subscription**, select your Azure Subscription.
- Under **Role**, select **Azure Maps Data Reader**.
- Click **Save**.
- Click **Add**.
- Click **Save**.

### Key Vault Secrets
- Click **Go to resource".
- On the Key Vault Blade, click **Secrets**
- Click **+Generate/Import**.

- Fill in the fields.

    - **Name**, enter **ClientId**.
    - **Value**, enter **Azure Maps Client ID** from above step.
- Click **Create**.

- Click **+Generate/Import**.

- Fill in the fields.

    - **Name**, enter **SubscriptionKey**.
    - **Value**, enter **Azure Maps Subscription Key** from above step.
- Click **Create**.

### App Service Configuration
- On the App Service Blade, click **Configuration**
- Under **Application Settings**, click **+New application setting**.
- Enter **AzureMaps:ClientId** for name.
- Enter **@Microsoft.KeyVault(VaultName=<keyvaultnamehere>;SecretName=ClientId)**. i.e. **keyvault-<*lastname*>**.
- Click **Ok**.

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

## Authentication - Subscription Key
  - coming soon...
- Authentication - Anonymous with Token.
  - coming soon...
  
## Deployment Pipeline version of Setup


## Deploy Resources OR Create them manually
- Create Resource Group in Azure.
- TBD, output will be maps name, app service name, keyvault name

## Build and Deployment
- This example uses Biep for Infrastructure as Code.
- step 1
- step 2
- step 3

## .Net 6.0 Application Update
### appsettings.json
- To implement AAD Authentication, update the appsettings.json file with settings from above steps.
- Under **AzureAd**.
    - "Instance": "https://login.microsoftonline.com/",
    - "Domain": "<your AAD domain>", (i.e. **microsoft.onmicrosoft.com**)
    - "TenantId": "<your tenant ID>",
    "AppRegClientId": "<Application Registration Id>",
    "CallbackPath": "/signin-oidc"
    
- To implement Azure Token Authentication, update the appsettings.json file with settings from above steps.
- Under **Azure Maps**.
    - "ClientId": "{{ Client ID From Azure Maps Account }}"
    - "Tenant": "{{ Azure Tenant ID }}"
    - "AppRegClientId": "{{ Client ID From Azure App Registration }}"

## Resources
- The project is based on the Example Azure Maps with protected website [Repo by Clemens](https://github.com/cschotte/Maps) | [Blog by Clemens](TBD) |
- [Azure-Portal](https://portal.azure.com/)
- [Use the Azure Maps map control]([https://portal.azure.com/](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-use-map-control)
- [Choose an authentication and authorization scenario]([https://portal.azure.com/](https://docs.microsoft.com/en-us/azure/azure-maps/how-to-manage-authentication#choose-an-authentication-and-authorization-scenario)

    
    
