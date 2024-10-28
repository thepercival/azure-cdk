
// pipeline parameters
param environment sys.string

// parameters.json test
param logWorkspace object
param keyVault object

var logWorkspaceName = '${logWorkspace.name}-${environment}'
var keyVaultName = '${keyVault.name}-${environment}'

module modLogWorkspace 'rg-core/operational-insights-workspace.bicep' = {
  name: 'logWorkspace'
  params: {
    workspaceName: logWorkspaceName
    sku: logWorkspace.sku
    retentionInDays: logWorkspace.retentionInDays[environment]
    resourcePermissions: logWorkspace.resourcePermissions
    heartbeatTableRetention: logWorkspace.heartbeatTableRetention
  }
}

module modKeyVault 'rg-core/keyvault.bicep' = {
  name: 'keyVault'
  params: {
    name: '${keyVault.name}-${environment}'
    sku: keyVault.sku
  }
}

// add permissions per appreg
module modRoleAssignmentKeyVaultOfficer 'rg-core/keyvault-roleassignment.bicep' = {
  name: guid(keyVaultName,  keyVault.secretsOfficers.principalId)
  params: {
    keyVaultName: keyVaultName
    principalId: keyVault.secretsOfficers.principalId
    principalType: 'Group'
    role: 'Key Vault Secrets Officer'
  }
}

module modRoleAssignmentKeyVaultUsers 'rg-core/keyvault-roleassignment.bicep' = [
  for secretsUser in keyVault.secretsUsers[environment]: {
    name: guid(keyVaultName,  secretsUser.principalId)
    params: {
      keyVaultName: keyVaultName
      principalId: secretsUser.principalId
      principalType: 'ServicePrincipal'
      role: 'Key Vault Secrets User'
    }
}]


