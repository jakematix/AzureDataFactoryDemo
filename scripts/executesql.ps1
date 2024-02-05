<#
    .SYNOPSIS
    This script executes a SQL script in Azure SQL Server.
    
    .DESCRIPTION
    This script executes a SQL script in Azure SQL Server. 
    The script is in the parameter file of this script.
    PowerShell script gets the SQL server connection string from the Azure Key Vault.
    This assumes that the PowerShell is run using the correct Service Principal and the Azure Infrastructure 
    (incl. Key Vault) has been created using the same Service Principal e.g., using the Terraform script.

    .PARAMETER -scriptFile
    Indicates the SQL file where the script is

    .PARAMETER -connectionStringKey
    Indicates the name of the connection string in the Key Vault

    .EXAMPLE
    PS> executesql -scriptFile .\createtable.sql -connectionStringKey "sqlconnectionstring"
 #>


param(
    [Parameter(Mandatory)]$scriptFile, 
    [Parameter(Mandatory)]$connectionStringKey
)

[String]$tableCreationQuery = Get-Content -Path $scriptFile

# Get the Keyvault name and metadata
$kvName = az keyvault list | ConvertFrom-Json

# Get the SQL Server connection string
$connectionString = az keyvault secret show --vault-name $kvName.name --name $connectionStringKey  | ConvertFrom-Json



# Execute the SQL command using Invoke-Sqlcmd
try {
    Invoke-Sqlcmd -ConnectionString $connectionString.Value -Query $tableCreationQuery
    Write-Host "SQL Query executed"
}
catch {
    Write-Host "`nError Message: " $_.Exception.Message
}
