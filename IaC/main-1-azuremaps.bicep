param azuremapname string
param location string = resourceGroup().location

resource azuremaps 'Microsoft.Maps/accounts@2021-12-01-preview' = {
  name: azuremapname
  location: location
  sku: {
    name: 'G2'
  }
  kind: 'Gen2'
  identity: {
    type: 'None'
  }
  properties: {
    disableLocalAuth: false
    cors: {
      corsRules: [
        {
          allowedOrigins: []
        }
      ]
    }
  }
}

// Avoid outputs for secrets - Look up secrets dynamically
// https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/scenarios-secrets
var AzureMapsSubscriptionKeyString = azuremaps.listKeys().primaryKey

output out_AzureMapsAppKey string = azuremaps.id
output out_AzureMapsClientId string = azuremaps.properties.uniqueId
output out_AzureMapsSubscriptionKey string = AzureMapsSubscriptionKeyString
