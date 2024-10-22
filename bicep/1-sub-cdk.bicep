targetScope='subscription'

// pipeline parameters
param environment sys.string
param resourceGroupName sys.string
param resourceGroupLocation sys.string

resource resResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

output message string = 'resourceGroup "${resourceGroupName}" deployed in environment "${environment}"'
