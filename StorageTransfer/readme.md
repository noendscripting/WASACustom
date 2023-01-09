# Transfering Files Via Storage Account

## Requirments

### Client

* Azure Subscrinstrion
* Storage Account with Contributor Access or ability to create new storage account

### Engineer 

Azure Storage Explorer App Installed

## Create Azure Storage Account

* Instruct client to start creating storage account [using Azure Documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal#create-a-storage-account-1)

* At the configuration screen select "Locally-redundand storage" to save costs and then click Review + Create

![Storage configuration](./Images/Image1.png)

## Configure Network Firewall Settings 

* Navigate to the newly created account and select Networking
* Select "Enable from Selected Virtual Networks and Ip Addresses"
* Add your external IP [here is how to find]() and client's external IP which can be found on the page
* Save Configiration

![networking](./Images/Image2.png)

## Create Contauner and upload reports

* Navigate to the container section and click "+ Container"

![new container](./Images/Image3.png)

* Create a new container 

![create new container](./Images/Image4.png)

* Click Upload buttion to get Upload files dialog

![upload button](./Images/Image5.png)

* Click on a folder button and navigate to the reports section

![upload files](./Images/Image6.png)

## Create SAS token for access

* Click on 'Shared Access Token' while still inside the container

![SAS token screen](./Images/Image7.png)

* Select Read + List rights in the drop down
* Select Start and Expiry times
* Optional: add your ( engineer)  public IP address in the box
* Click "Generate SAS Token and URL"

![create SAS token](./Images/Image8.png)

* Once URL is generated save the "Blob SAS Url" value

![save SAS url](./Images/Image9.png)

## Download report with Azure Storage Explorer

* Start Azure Storage Explorer
* Click on connect button

![connect button](./Images/image10.png)

* Select "Blob container" at the next dialog window

![select blob](./Images/Image11.png)

* Select "Shared Access Signature URL" and click Next

![select SAS](./Images/Image12.png)

* Provide connection name, paste SAS URL obtained in the steps above and click "Next"

![provide SAS URL](./Images/Image13.png)

* Use Donwload button to download reports to your computer

![download](./Images/Image14.png)
