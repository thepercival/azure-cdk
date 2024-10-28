targetScope = 'subscription'

param entraGroupObjectId string
param roleDefinitionId string

// extension microsoftGraph

// resource resGroup 'Microsoft.Graph/groups@v1.0' existing = {
//   uniqueName: groupName
// }
// output resGroupId string = resGroup.id
// output roleDefinitionId string = roleDefinitionId

resource resGroupAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(entraGroupObjectId ,roleDefinitionId)
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: entraGroupObjectId
  }
}


