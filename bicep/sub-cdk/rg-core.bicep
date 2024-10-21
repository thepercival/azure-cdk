targetScope='subscription'

param resourceGroup object

resource newRG 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroup.name
  location: resourceGroup.location
}


// pipeline parameters
param environment sys.string

// parameters.json
param logWorkspace object

var logWorkspaceName = '${logWorkspace.name}-${environment}'


module modLogWorkspace '../modules/monitoring/1-operational-insights-workspace.bicep' = {
  name: 'logWorkspace'
  params: {
    workspaceName: logWorkspaceName
    sku: logWorkspace.sku
    retentionInDays: logWorkspace.retentionInDays
    resourcePermissions: logWorkspace.resourcePermissions
    heartbeatTableRetention: logWorkspace.heartbeatTableRetention
  }
}
var logWorkspaceId = modLogWorkspace.outputs.id

module modDiagnosticSettings 'modules/monitoring/2-diagnostic-settings.bicep' = {
  name: 'diagnosticSettings'
  scope: subscription()
  params: {
    logAnalyticsWorkspaceId: logWorkspaceId
  }
}
