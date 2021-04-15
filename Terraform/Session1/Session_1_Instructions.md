# Session 1

The goal of this session is to deploy one Linux VM to Azure. We are working exclusively in VS Code using the terminal. Ensure you have installed Az CLI and Terraform before proceeding, otherwise it won't work.

Step 1: **Set Az CLI for the target cloud**.

- In a terminal session, for commercial Azure subscriptions (this includes MSDN accounts) type `az cloud set --name AzureCloud`
  - If you are targeting an Azure Government subscription, enter `--name AzureUSGovernment`

![Azure Cloud List](/.attachments/az-cloud-list-output-table.png)

Step 2: **Log into subscription**.

- In a terminal session, type `az login` and use browser authentication to log into the target Azure subscription.

![Azure Login Success](/.attachments/az-login-success.jpg)

Step 3: **Change directory to Session 1 folder**.

- Change the local working directory in VS Code to the Session 1 folder containing the first terraform configuration file.

![VS Code Change Directory](/.attachments/change-dir-to-sess-1.png)

Step 4: **Initialize Terraform**

- The VS Code terraform plugin will likely recognize a terraform file exists and has no associated state or lock file, and the declared providers are not present.

![Terraform Plugin Alert](/.attachments/Terraform-run-init.png)

- Initialize the terraform process on the file by running `terraform init`

![Terraform Init](/.attachments/terraform-init.png)

## Commands

az account show
az account set --subscription SUB_NAME

terraform init
terraform plan -out singleVM.tfplan
terraform apply "vnet.tfplan"
