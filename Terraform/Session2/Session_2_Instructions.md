# Session 2

The goal of this session is to demonstrate splitting the Terraform configuration into three files; main.tf, variables.tf, and output.tf. We are still working exclusively in VS Code using the terminal and connecting to the same Azure environment. This is building upon the settings and configuration from Session 1.

Step 1: **Set Az CLI for the target cloud**.

- In a terminal session, type `az cloud set --name AzureCloud`
  - This is the default for commercial Azure subscriptions including MSDN accounts
  - If you are targeting an Azure Government subscription, enter `--name AzureUSGovernment`

![Azure Cloud List](/.attachments/az-cloud-list-output-table.png)

Step 2: **Log into subscription**.

- In a terminal session, type `az login` and use browser authentication to login to your Azure subscription.

![Azure Login Success](/.attachments/az-login-success.jpg)

Step 3: **Change directory to Session 2 folder**.

- Change the local working directory in VS Code to the Session 2 folder.

![VS Code Change Directory](/.attachments/change-dir-sess2.png)

Step 4: **Initialize Terraform**

- The VS Code terraform plugin will likely recognize a terraform file exists but has no associated state or lock file and providers are not present.

![Terraform Plugin Alert](/.attachments/Terraform-run-init.png)

- Initialize the terraform process on the file by running `terraform init`

![Terraform Init](/.attachments/terraform-init.png)

Step 5: **Plan the Terraform deployment**

- Plan the Terraform deployment and save the plan in a separate file by entering the command `terraform plan -out SingleVM.tfplan`
- Quick note about terraform plan; running `terraform plan` will print the plan to the terminal and its not stored elsewhere. Outputting the plan to a .tfplan file will enable later review of the plan.

![Terraform Plan start](/.attachments/tf-plan1.png)

... the plan is creating ...

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

- Once the destroy plan is complete, type `yes` to execute

![Terraform Destroy Confirm](/.attachments/tf-destroy2.png)

... executing the destroy ...

![Terraform Destroy Complete](/.attachments/tf-destroy3.png)

- You should now see all resources removed in your portal.

**End of session 2**
