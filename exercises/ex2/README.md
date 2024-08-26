# Exercise 2 - Create a subaccount

In this exercise, we will use Terraform to create a subaccount in your global account.

## Exercise 2.1 - Create the Terraform configuration

After completing these steps you will have defined the configuration for the subaccount creation using Terraform

To setup a subaccount we must identify the fitting Terraform resource. The official documentation will help us with this. As we want to create subaccount the resource we are looking for is the resource [`btp_subaccount`](https://registry.terraform.io/providers/SAP/btp/latest/docs/resources/subaccount). In the documentation we find all the required and optional parameters we can use to configure the subaccount. We want to use the following parameters for our subaccount:

- `name` - the name of the subaccount. As we do not want to hard code the name, we will be suing a variable for this.
- `subdomain` - The value for the subdomain. To keep this unique we want to define this as a combination of a user-provided prefix plus a random UUID. No matter what the user provides as prefix, we will always transform the value to lowercase and replace all `_` with `-`.
- `region` - the region where the subaccount should be created. We want to be flexible, so we will use a variable for this. To make it easy for the user we ensure that no matter how the variable is provided, we always transform the value to lowercase.

So let's do that.

1. First we define the variables that we later use in the configuration. Open the file `variables.tf` and add the following code to define the three variables for *subaccount name*, *subaccount domain prefix*  and *region*.

      ```terraform
      variable "subaccount_domain_prefix" {
        type        = string
        description = "The prefix used for the subaccount domain"
        default     = "TechEd2024-TF"
      }
      
      variable "subaccount_id" {
        type        = string
        description = "The subaccount ID."
        default     = ""
      }
      
      variable "subaccount_name" {
        type        = string
        description = "The subaccount name."
        default     = "TechEd2024-experiments"
      }
      ```

      It is best practice to provided a meaningful description for the variables. As you can see we also provided default values for the variables. Feel free to change them to your liking. Safe your changes once you are finished.

      As we have defined the necessary input, we can now start with the actual configuration.

1. As we need some construct the subaccount domain we must leverage a few features of Terraform to achieve this namely:

    - Use a [local variable](https://developer.hashicorp.com/terraform/language/values/locals) to construct the value based on the input.
    - The [`random_uuid` resource](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) to make the value unique. 
    - Two Terraform built-in functions to [replace](https://developer.hashicorp.com/terraform/language/functions/replace) the `_` with `-` and to make the value all [lower](https://developer.hashicorp.com/terraform/language/functions/lower) case.

    Let us bring this together. Open the `main.tf` file and add the following code to fetch a random UUID and construct the subaccount domain:

    ```terraform
    resource "random_uuid" "uuid" {}

    locals {
      subaccount_domain = lower(replace("${var.subaccount_domain_prefix}-${random_uuid.uuid.result}", "_", "-"))
    }
    ```

1. With this we can continue to define the actual subaccount resource. Add the following code to the `main.tf` file:

    ```terraform
    resource "btp_subaccount" "my" {
      name      = var.subaccount_name
      subdomain = local.subaccount_domain
      region    = lower(var.region)
    }
    ```

    We are using the variables we defined before and the local variable to fill the required parameters of the resource. We are also using the `lower` function inline to ensure that the region is always in lowercase.

    Safe your changes, as we can now give the configuration a try.

## Exercise 2.2 - Execute Terraform

After completing these steps you will have executed the Terraform configuration and successfully created a subaccount in your global account.

1. As we are using Terraform for the first time we must initialize the setup. We do so via the command

    ```bash
    terraform init
    ```

    This will initialize the setup and download the required provider. You can also check your file system to see that a `.terraform` directory has been created.

2. Next we want to check what Terraform will do when we apply the configuration. We do so via the command

    ```bash
    terraform plan
    ```

    This will show you what Terraform will do if we would apply the configuration. This step is important to validate if the configuration is acting as expected. We will also save the plan to a file for using it later. Execute the following command:

    ```bash
    terraform plan -out=tfplan
    ```

    You should see that Terraform would create a subaccount with the parameters you provided. This looks good, so let us apply the plan via:

    ```bash
    terraform apply tfplan
    ```

    As a result you see in the output that Terraform is creating the subaccount. You can also check the SAP BTP cockpit to see the subaccount being created.

## Summary

You've now made the first step in defining your SAP BTP infrastructure as Code namely the creation of a subaccount. 

Continue to - [Exercise 3 - Setup of SAP Build Code](../ex3/README.md)
