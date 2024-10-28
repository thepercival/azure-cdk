
// pipeline parameters
param environment sys.string

// parameters.json test
param logWorkspace object
param keyVault object

var logWorkspaceName = '${logWorkspace.name}-${environment}'

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


