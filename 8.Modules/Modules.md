# Modules

Terraform modules are a way to organize and reuse configurations. They allow you to group related resources and their configurations into a single unit, which can then be used multiple times throughout your infrastructure code. Using modules helps to manage complexity and improve maintainability by encapsulating commonly used patterns and configurations. Here's an overview of how modules work and how to use them effectively in Terraform:

### Key Concepts of Terraform Modules
**Root Module:** This is the top-level module in a Terraform configuration. It consists of the main .tf files in the directory where you run Terraform commands. The root module can call child modules.

**Child Module:** A module that is called by another module. It can be defined in a separate directory or as a published module in the Terraform Registry.

**Module Source:** The location of a module, which can be a local path, a versioned module in the Terraform Registry, a Git repository, or other supported locations.
[Module Source](https://developer.hashicorp.com/terraform/language/modules/sources)

**Module Input Variables:** Variables defined in the module to accept values from the calling module. These are similar to input parameters for a function.

**Module Output Values:** Values that a module outputs back to the calling module. These allow data to be passed out of the module.