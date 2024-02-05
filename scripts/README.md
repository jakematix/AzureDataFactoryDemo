# PowerShell script to execute SQL queries in Azure MS SQL Server
PowerShell script `executesql.ps1` is used to make SQL queries to MS SQL Server.<br> 
It needs the following mandatory parameters:
* `--scriptFile` - name of the file, that contains the SQL Query
* `--connectionStringKey`- Name of the Secret in Azure Key Vault that contains SQL DB Connection string

Example:
`.\executesql.ps1 --scriptFile .\configdata\table.sql --connectionStringKey "sqlconnectionstring"`
 