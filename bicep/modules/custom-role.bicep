targetScope = 'subscription'

@description('Array of actions for the roleDefinition')
param actions array

@description('Groups to assign the custom role to')
param entraGroups array

@description('Array of notActions for the roleDefinition')
param notActions array = []

@description('Friendly name of the role definition')
param name string

@description('Detailed description of the role definition')
param roleDescription string

var roleDefName = guid(name)

resource resRoleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: name
    description: roleDescription
    type: 'customRole'
    permissions: [
      {
        actions: actions
        notActions: notActions
      }
    ]
    assignableScopes: [
      subscription().id
    ]
  }
}

@sys.description('group assignments.')
module modRoleAssignments 'customrole-assignments.bicep' = [
  for entraGroup in entraGroups: {
    name: 'customRoleAssignment-${entraGroup.name}'
    params: {
      roleDefinitionId: resRoleDef.id
      entraGroupObjectId: entraGroup.objectId
    }
}
]

