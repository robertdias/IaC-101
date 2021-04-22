# IaC-101

Infrastructure as Code for beginners. This repo focuses on learning Terraform basics on Azure.

**Session 1.** Deploy a basic Terraform file using your local machine. This will create one linux VM in your Azure environment. (v1.0.0)
**Session 2.** Create a composite terraform configuration using input variables and output files. (future)

Prerequisites:

- Access to an Azure subscription
  - Get a [free sub here](https://azure.microsoft.com/en-us/free/search/?OCID=AID2100131_SEM_e3f23ff64dfe1dbd75325f8fc70875fb:G:s&ef_id=e3f23ff64dfe1dbd75325f8fc70875fb:G:s&msclkid=e3f23ff64dfe1dbd75325f8fc70875fb)

We will cover topics like:

- Using input variables and outputs
- What is 'remote state' and how to store the state file in a secure manner
- When to use certain elements like count, ternary ops, loops, modules, etc

Using the Infrastructure as Code (IaC) System

To be able to develop Terraform templates and GitHub workflows, install the following software on your workstation:

- [Git](https://git-scm.com/download/win) or `choco install git`
- [Visual Studio Code](https://code.visualstudio.com/) or `choco install vscode.install`
- [Terraform](https://www.terraform.io/downloads.html) or `choco install terraform`
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) or `choco install azure-cli`
- [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1) or `choco install azurepowershell`

Click on the links above and install the packages following the instructions provided.
Next, start VS Code and install extensions. Some of the ones we recommend are listed below:

- [Azure Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack)
- [Azure Terraform](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)
- [Azure Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)
- [Azure Storage Explorer](https://marketplace.visualstudio.com/items?itemName=formulahendry.azure-storage-explorer)
- [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)

## Resources

- [Using Git](https://docs.github.com/en/github/using-git)
- [Creating GitHub Actions](https://docs.github.com/en/actions/creating-actions)
- [GitHub Actions Marketplace (Azure)](https://github.com/marketplace?type=actions&query=Azure)
- [GitHub Workflow Syntax](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions)
