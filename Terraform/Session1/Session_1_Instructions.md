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

Step 5: **Plan the Terraform deployment**

- Plan the Terraform deployment and save the plan in a separate file by entering the command `terraform plan -out SingleVM.tfplan`

![Terraform Plan start](/.attachments/tf-plan1.png)
...
![Terraform Plan finish](/.attachments/tf-plan2.png)

Step 6: **Apply the Terraform configuration**

- Now we are going to make our configuration a real item.
- Apply the previously generated terraform plan by entering the command `terraform apply SingleVM.tfplan`

![Terraform Apply Start](/.attachments/tf-apply0.png)

... the plan continues to apply ...

![Terraform Apply Finish](/.attachments/tf-apply1.png)

Step 7: **Verify Deployment in portal**

- Open the Azure portal and see your newly created resources.
  
![Terraform Verify Deployment](/.attachments/tf-apply2.png)

Step 8: **Burn it down!!**

- Remove all deployed resources by issuing `terraform destroy`

![Terraform Destroy Start](/.attachments/tf-destroy1.png)

... planning the destruction ...

![Terraform Destroy Confirm](/.attachments/tf-destroy2.png)

... executing the destroy ...

![Terraform Destroy Complete](/.attachments/tf-destroy3.png)
