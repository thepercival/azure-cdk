targetScope='subscription'

// pipeline parameters
param environment sys.string

// parameters.json
param resourceGroup object

resource resResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroup.name
  location: resourceGroup.location
}
