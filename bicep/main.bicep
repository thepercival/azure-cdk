
// pipeline parameters
param environment sys.string

// parameters.json
param logWorkspace object

var logWorkspaceName = '${logWorkspace.name}-${environment}'


module modLogWorkspace 'modules/monitoring/1-log-analytics-workspace.bicep' = {
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
