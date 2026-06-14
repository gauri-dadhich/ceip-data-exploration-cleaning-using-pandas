# Azure Cloud Fundamentals and Data Pipeline Implementation using Azure Data Factory

## Assignment Overview

This Assignment contains Screenshots of implemtation and Documentation of Mini Project with execution steps that demonstrates the implementation of an end-to-end data pipeline using Microsoft Azure services. The pipeline reads a CSV dataset from Azure Blob Storage, validates file metadata using Azure Data Factory (ADF), and copies the data to a destination location.

The project covers Azure resource provisioning, storage management, data integration, pipeline orchestration, monitoring, and access control using Azure IAM roles.

## Azure Services Used

* Azure Resource Group
* Azure Storage Account
* Azure Blob Storage
* Azure Data Factory (ADF)
* Azure IAM (Access Control)

## Resources Created

### Resource Group

* `gauriassignment`

### Storage Components

* Storage Account: `storageaccassignment`
* Source Container: `assignmentcontainer`
* Destination Container: `output`

### Azure Data Factory

* Data Factory: `assignmenttgdadf`
* Linked Service: `AzureBlobStorage1`
* Source Dataset: `assignmentdataset`
* Destination Dataset: `assignmentdestination`

## Pipeline Workflow

### 1. Metadata Validation

The **Get Metadata** activity validates the source file before processing.
Checks performed:
* File Exists
* File Size
### 2. Data Copy
The **Copy Data** activity copies the CSV file from the source container to the destination container.


## Implementation Steps

1. Created an Azure Resource Group.
2. Created a Storage Account.
3. Created Blob Containers.
4. Uploaded the Superstore CSV dataset.
5. Created an Azure Data Factory instance.
6. Configured Linked Service for Blob Storage.
7. Created Source and Destination Datasets.
8. Added Get Metadata activity.
9. Added Copy Data activity.
10. Executed the pipeline using Debug.
11. Monitored execution through ADF Monitor.
12. Verified output file creation.
13. Configured IAM role assignments.

## IAM Roles Configured

### Reader

Provides read-only access to Azure resources.

### Contributor

Allows management of Azure resources.

### Storage Blob Data Contributor

Assigned to Azure Data Factory Managed Identity to enable access to Blob Storage.

## Output

### Source File

* `Sample - Superstore.csv`
### Destination File

* `salesoutput.csv`
### Pipeline Status

* Succeeded
### Metadata Validation

* Successful
### Data Transfer

* Successful

## Results

* Successfully created Azure cloud resources.
* Successfully configured Azure Data Factory.
* Successfully validated source file metadata.
* Successfully copied data between Blob Storage containers.
* Successfully monitored pipeline execution.
* Successfully configured IAM access control.
* Successfully generated output file in destination container.

## Screenshots

Screenshots of the implementation, pipeline execution, IAM configuration, and output verification are available in the project documentation.
## Conclusion

This Mini project demonstrates the development of a complete Azure Data Pipeline using Azure Blob Storage and Azure Data Factory. The implementation validates source data using Get Metadata activity, transfers data using Copy Data activity, and secures resource access through Azure IAM roles.
