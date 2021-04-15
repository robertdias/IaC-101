# Session 1

The goal of this session is to deploy one Linux VM to Azure. We are working exclusively in VS Code using the terminal. Ensure you have installed Az CLI and Terraform before proceeding, otherwise it won't work.

Step 1: **Set Az CLI for the target cloud**.

- In a terminal session, for commercial Azure subscriptions (this includes MSDN accounts) type `az cloud set --name AzureCloud`
  - If you are targeting an Azure Government subscription, enter `--name AzureUSGovernment`

![](/.attachments/az-cloud-list-output-table.png)

Step 2: **Log into subscription**.

- In a terminal session, type `az login` and use browser authentication to log into the target Azure subscription.

![](/.attachments/az-login-success.jpg)

Step 3: **Change directory to Session 1 folder**.
