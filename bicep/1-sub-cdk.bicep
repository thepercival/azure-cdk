targetScope='subscription'

// pipeline parameters
param environment sys.string
param resourceGroupName sys.string
param resourceGroupLocation sys.string
param customRole object

resource resResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}



@sys.description('Deployment of resources.')
module modCustomRole 'modules/custom-role.bicep' = {
  name: 'customRole'
  params: {
    name: customRole.name
    roleDescription: customRole.description
    actions: customRole.actions
    entraGroups: customRole.entraGroups[environment]
  }
}

output message string = 'resourceGroup "${resourceGroupName}" deployed in environment "${environment}"'
