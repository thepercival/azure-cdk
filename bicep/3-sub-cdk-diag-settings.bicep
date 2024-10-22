targetScope='subscription'

// pipeline parameters
param environment sys.string

// parameters.json
param logWorkspace object
param diagnosticSettings object

var logWorkspaceName = '${logWorkspace.name}-${environment}'

resource resLogWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing =  {
  name: logWorkspaceName
  scope: resourceGroup(diagnosticSettings.resourceGroupName)  
}

module modDiagnosticSettings 'sub-cdk/rg-core/diagnostic-settings.bicep' = {
  name: 'diagnosticSettings'
  params: {
    logAnalyticsWorkspaceId: resLogWorkspace.id
    
  }
}

output message string = 'diagnosticSettings deployed for subscription'
