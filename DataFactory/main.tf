# Creation of Azure Data Factory
resource "azurerm_data_factory" "datafactory" {
  name                = "${var.name_construct}DF7726860"
  location            = var.region
  resource_group_name = var.rg_name
}

# Creation of the Data Factory pipeline
resource "azurerm_data_factory_pipeline" "datafactorypipeline" {
  name                = "${var.name_construct}BlobToSQL"
  data_factory_id     = azurerm_data_factory.datafactory.id
}

# Creation of the Linked service to the Blob
resource "azurerm_data_factory_linked_service_azure_blob_storage" "bloblink" {
  name              = "${var.name_construct}BlobLink"
  data_factory_id   = azurerm_data_factory.datafactory.id
  connection_string = var.blob_connection_string
}

# Creation of the Blob storage dataset
resource "azurerm_data_factory_dataset_azure_blob" "blobdataset" {
  name                = "${var.name_construct}BlobDataset"
  data_factory_id     = azurerm_data_factory.datafactory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.bloblink.name
}


# Settings for delimited text aka. CSV file
#resource "azurerm_data_factory_dataset_delimited_text" "csvfile" {
#  name                = "${var.name_construct}csv"
#  data_factory_id     = azurerm_data_factory.datafactory.id
#  linked_service_name = azurerm_data_factory_dataset_azure_blob.blobdataset.name
#  
#  azure_blob_storage_location {
#    filename = "GlobalLandTemperatures.csv"
#    container = "sourcedata"
#  }

#  column_delimiter    = ","
#  row_delimiter       = "NEW"
#  encoding            = "UTF-8"
#  quote_character     = "x"
#  escape_character    = "f"
#  first_row_as_header = true
#  null_value          = "NULL"
# }


