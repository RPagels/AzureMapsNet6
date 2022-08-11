param keyvaultName string
param webappName1 string
param webappName2 string
param webappName3 string
//param functionAppName string
// param secret_AzureWebJobsStorageName string
// param secret_WebsiteContentAzureFileConnectionStringName string
param appInsightsInstrumentationKey string
param appInsightsConnectionString string

param KeyVault_ClientIdName string

@secure()
param KeyVault_ClientIdValue string

param KeyVault_SubscriptionKeyName string

@secure()
param KeyVault_SubscriptionKeyValue string

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
resource existing_appService1 'Microsoft.Web/sites@2021-03-01' existing = {
  name: webappName1
}

// Create Web sites/config 'appsettings' - Web App
resource webSiteAppSettingsStrings1 'Microsoft.Web/sites/config@2021-03-01' = {
  name: 'appsettings'
  parent: existing_appService1
  properties: {
    WEBSITE_RUN_FROM_PACKAGE: '1'
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
    APPINSIGHTS_PROFILERFEATURE_VERSION: '1.0.0'
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION: '1.0.0'
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsightsConnectionString
    WebAppUrl: 'https://${existing_appService1.name}.azurewebsites.net/'
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

// Create KeyVault Secrets
resource secret2 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  name: KeyVault_SubscriptionKeyName
  parent: existing_keyvault
  properties: {
    value: KeyVault_SubscriptionKeyValue
  }
}

// Reference Existing resource
resource existing_appService2 'Microsoft.Web/sites@2021-03-01' existing = {
  name: webappName2
}

// Create Web sites/config 'appsettings' - Web App
resource webSiteAppSettingsStrings2 'Microsoft.Web/sites/config@2021-03-01' = {
  name: 'appsettings'
  parent: existing_appService2
  properties: {
    WEBSITE_RUN_FROM_PACKAGE: '1'
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
    APPINSIGHTS_PROFILERFEATURE_VERSION: '1.0.0'
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION: '1.0.0'
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsightsConnectionString
    WebAppUrl: 'https://${existing_appService2.name}.azurewebsites.net/'
    ASPNETCORE_ENVIRONMENT: 'Development'
    'AzureMaps:AadAppId': 'c0d1eb87-0cec-40aa-a7d5-87b5f9c09ee7'
    'AzureMaps:AadTenant': '72f988bf-86f1-41af-91ab-2d7cd011db47'
    'AzureMaps:ClientId': '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=${KeyVault_ClientIdName})'
    'AzureMaps:SubscriptionKey': '@Microsoft.KeyVault(VaultName=${keyvaultName};SecretName=${KeyVault_SubscriptionKeyName})'
    'Debug Only1': 'ClientId = ${KeyVault_ClientIdValue}'
    'Debug Only2': 'ClientId = ${KeyVault_SubscriptionKeyValue}'
  }
  dependsOn: [
    secret2
  ]
}


