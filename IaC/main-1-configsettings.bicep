param keyvaultName string
param webappName string
//param functionAppName string
// param secret_AzureWebJobsStorageName string
// param secret_WebsiteContentAzureFileConnectionStringName string
param appInsightsInstrumentationKey string
param appInsightsConnectionString string

param KeyVault_ClientIdName string

@secure()
param KeyVault_ClientIdValue string

@secure()
param appServiceprincipalId string

@secure()
param funcAppServiceprincipalId string

// @secure()
// param secret_AzureWebJobsStorageValue string

param tenant string

// Define KeyVault accessPolicies
param accessPolicies array = [
  {
    tenantId: tenant
    objectId: appServiceprincipalId
    permissions: {
      keys: [
        'Get'
        'List'
      ]
      secrets: [
        'Get'
        'List'
      ]
    }
  }
  {
    tenantId: tenant
    objectId: funcAppServiceprincipalId
    permissions: {
      keys: [
        'Get'
        'List'
      ]
      secrets: [
        'Get'
        'List'
      ]
    }
  }
]

// Reference Existing resource
resource existing_keyvault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyvaultName
}

// Create KeyVault accessPolicies
resource keyvaultaccessmod 'Microsoft.KeyVault/vaults/accessPolicies@2022-07-01' = {
  name: 'add'
  parent: existing_keyvault
  properties: {
    accessPolicies: accessPolicies
  }
}

// Create KeyVault Secrets
resource secret1 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  name: KeyVault_ClientIdName
  parent: existing_keyvault
  properties: {
    value: KeyVault_ClientIdValue
  }
}

// Reference Existing resource
resource existing_appService 'Microsoft.Web/sites@2021-03-01' existing = {
  name: webappName
}

// Create Web sites/config 'appsettings' - Web App
resource webSiteAppSettingsStrings 'Microsoft.Web/sites/config@2021-03-01' = {
  name: 'appsettings'
  parent: existing_appService
  properties: {
    WEBSITE_RUN_FROM_PACKAGE: '1'
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
    APPINSIGHTS_PROFILERFEATURE_VERSION: '1.0.0'
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION: '1.0.0'
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsightsConnectionString
    WebAppUrl: 'https://${existing_appService.name}.azurewebsites.net/'
    ASPNETCORE_ENVIRONMENT: 'Development'
    'AzureMaps:AadAppId': 'c0d1eb87-0cec-40aa-a7d5-87b5f9c09ee7'
    'AzureMaps:AadTenant': '72f988bf-86f1-41af-91ab-2d7cd011db47'
    'AzureMaps:ClientId': '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=${KeyVault_ClientIdName})'
    'Debug Only': 'ClientId = ${KeyVault_ClientIdValue}'
  }
  dependsOn: [
    secret1
  ]
}



