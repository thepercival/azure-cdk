
// pipeline parameters
param environment sys.string

// parameters.json
param logWorkspace object

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


