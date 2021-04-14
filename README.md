# IaC-101

Infrastructure as Code for beginners. This repo focuses on learning Terraform basics.

1. Deploy a basic Terraform file using your local machine.
2. We will 

Prerequisites:

- MSDN account
- Az CLI or Az PoSH
- terraform.exe

When to use certain elements like count, ternary ops, loops, modules, remote state, etc

Setting up the new IaC repo for your project

Follow these instructions to create a new repository based on the template for this IaC repository. When you do make sure you set the repo visibility to PRIVATE as this code base is not public.
The new repository structure should look like the following:
 
• The Terraform directory contains the code we will be using / deploying in the sessions.
• The .github directory contains the github workflows developed for the project to deploy Azure resources. These workflows are stored in the workflow sub-directory and they call the GitHub actions located in the actions sub-directory.

Using the Infrastructure as Code (IaC) System
Install the software needed
To be able to develop Terraform templates and GitHub workflows, we recommend you install the following software on your workstation:

•	Git
•	Visual Studio Code

Click on the links above and install the two packages by following the instructions provided.
Then start VS code and install your favorite extensions. Some of the ones we recommend are listed below:

•	GitLens — Git supercharged
•	Terraform by HashiCorp
•	YAML
•	Markdown All in One

# Resources

* Using Git: https://docs.github.com/en/github/using-git
  
* Creating Actions: https://docs.github.com/en/actions/creating-actions

* GitHub Actions Marketplace (Azure): https://github.com/marketplace?type=actions&query=Azure

* GitHub Workflow Syntax: https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions

# Setting up your development environment

## Install the software needed

To be able to develop IaC templates and GitHub workflows, we recommend you install the following software on your workstation:

* [Git](https://git-scm.com/download/win)
* [Visual Studio Code](https://code.visualstudio.com/Download)

Click on the links above and install the two packages by following the instructions provided.

Then start VS code and install your favorite extensions. Some of the ones we recommend are listed below:

* [GitLens — Git supercharged](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
* [Azure Resource Manager (ARM) Tools](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools)
* [Terraform](https://github.com/Azure/vscode-azureterraform)
* [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)

## Clone your repository

Go to your github organization and make sure you have created a repository for your project by following the instructions provided in [Setup your GitHub Repository for IaC](../Docs/Setup-your-GitHub-Repository-for-IaC.md).

Go to your repo, click on the **Code** button and copy the URL displayed as shown below.

![GitHub Clone Repo](.attachments/gitHub-clone.jpg)

Open VS Code, click on the *Source Control* icon and select **Clone Reporsitory**. Then paste the URL you copied in the previous step into the box displayed as shown below:

   <img src=".attachments/vs-code-clone.jpg" alt="VScode-clone" title="VScode Clone repo"/>

Then select the folder on your workstation where the repo will be cloned.

You are now ready to create a git branch for yourself in this repo and start contributing code. If you are not familiar with how version control works in Git or how to use it from VScode, please use the links below to ramp up:

* [Git Basics](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)
* [Using version control in VS Code](https://code.visualstudio.com/Docs/editor/versioncontrol)