# Exercise 4 - Setup of SAP Build Process Automation

In this exercise, we will we will enhance the existing configuration to setup SAP Build Process Automation leveraging a Terraform module.

> **Note** - You find the solution for this exercise in the [solutions/ex4](../../solutions/ex4/) folder.

## Exercise 4.1 - Become familiar with the SAP Build Process Automation module

After completing these steps you will know how the module for SAP Build Process Automation is structured.

As for the SAP Build Code scenario in the previous step, the setup comprises several components:

- Assignment of the entitlement for SAP Build Process Automation to the subaccount.
- Subscription to the SAP Build Process Automation application.
- Assignment of the role collections to the users to access the application.

As before we leverage a module for these tasks that is available in the folder `modules/build_process_automation`. The structure an content corresponds to the previous exercise. Take a few minutes to review the files in the module. Use this a  knowledge check from the previous exercise.

Once finished let us start to integrate the module into our main configuration.

## Exercise 4.2 - Configure the SAP Build Code module

After completing these steps you will have enhanced the configuration to setup SAP Build Process Automation.

1. As the new modules comes with a few new variables we must add those to our configuration. Open the `variables.tf` file, add the following code and safe your changes:

   ``` terraform
   variable "process_automation_admins" {
     type        = list(string)
     description = "Defines the users who have the role of ProcessAutomationAdmin in SAP Build Process Automation"
   }

   variable "process_automation_developers" {
     type        = list(string)
     description = "Defines the users who have the role of ProcessAutomationDeveloper in SAP Build Process Automation"
   }

   variable "process_automation_participants" {
     type        = list(string)
     description = "Defines the users who have the role of ProcessAutomationParticipant in SAP Build Process Automation"
   }
   ```

   This input will be used for the corresponding role collection assignment inside of the module.

1. We of course also need to provide the values for these variables. Open the `terraform.tfvars` file and add the following code:

   ``` terraform
   # users for SAP Build Process Automation
   process_automation_admins       = ["your.email@foo.xyz"]
   process_automation_developers   = ["your.email@foo.xyz"]
   process_automation_participants = ["your.email@foo.xyz"]
   ```

   Replace all appearances of `your.email@foo.xyz` with the email addresses of your SAP BTP user, so that you get the role collections assigned. Safe the changes.

1. Next we need to add the module to our configuration. Open the `main.tf` file and add the following code:


   ```terraform
   module "build_process_automation" {
     source = "../modules/build_process_automation"

     subaccount_id  = btp_subaccount.sa_build.id

     process_automation_admins       = var.process_automation_admins
     process_automation_developers   = var.process_automation_developers
     process_automation_participants = var.process_automation_participants
   }
   ```

   We provided the parameters based on our variables as well as with ID of the subaccount `btp_subaccount.sa_build.id` which we get returned from the corresponding resource. Safe your changes.

1. As a final step we propagate the output of the module via the outputs of our configuration. Open the `outputs.tf` file and add the following code:

   ```terraform
   output "url_sap_build_process_automation" {
     value = module.build_process_automation.url_build_process_automation
   }
   ```

    Safe your changes and let's give the enhanced configuration a try.

## Exercise 4.3 - Execute Terraform

After completing these steps you will have executed the Terraform configuration and successfully created a the SAP Build Process Automation resources in your subaccount.

1. As we added another module to our setup we must reinitialize the configuration to make Terraform aware of this. To achieve this execute the following command:

    ```bash
    terraform init -upgrade
    ```

    This will initialize the setup and download the required provider. You can also check your file system to see that a `.terraform` directory has been created.

1. Next we want to check what Terraform will do when we apply the configuration. We do so via the command

    ```bash
    terraform plan -out=tfplan
    ```

    This will show you what Terraform will do if we would apply the configuration. This step is important to validate if the configuration is acting as expected. We also saved the plan to a file for using it later.

    You should see that Terraform would create the SAP Build Process Automation setup. This looks good, so let us apply the plan via:

    ```bash
    terraform apply tfplan
    ```

    As a result you see that Terraform created the resources. As we specified dedicated output variables we also see them as separate section at the end of the output from the Terraform CLI.

## Summary

That's it folks! You've now completed the setup of an environment on SAP BTP comprising:

- The creation of an SAP BTP subaccount
- The setup of SAP Build Code
- The setup of SAP Build Process Automation

We hope you enjoyed the ride and learned something new along the way. If you have any questions or feedback, please don't hesitate to reach out to us.

With that ... happy Terraforming! 🚀
