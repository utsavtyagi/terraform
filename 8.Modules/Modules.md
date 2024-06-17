# Modules

Terraform modules are a way to organize and reuse configurations. They allow you to group related resources and their configurations into a single unit, which can then be used multiple times throughout your infrastructure code. Using modules helps to manage complexity and improve maintainability by encapsulating commonly used patterns and configurations. Here's an overview of how modules work and how to use them effectively in Terraform:

### Key Concepts of Terraform Modules
**Root Module:** This is the top-level module in a Terraform configuration. It consists of the main .tf files in the directory where you run Terraform commands. The root module can call child modules.

**Child Module:** A module that is called by another module. It can be defined in a separate directory or as a published module in the Terraform Registry.

**Module Source:** The location of a module, which can be a local path, a versioned module in the Terraform Registry, a Git repository, or other supported locations.

[Module Source](https://developer.hashicorp.com/terraform/language/modules/sources)

**Module Input Variables:** Variables defined in the module to accept values from the calling module. These are similar to input parameters for a function.

**Module Output Values:** Values that a module outputs back to the calling module. These allow data to be passed out of the module.

### Advantages of Using Modules

**Organization:** Encapsulate related resources and configurations.

**Reusability:** Write a module once and reuse it across different projects.

**Maintainability and Versioning:** Easier to manage and update infrastructure code. Modules can have their own versioning, making it easier to manage updates and changes.

**Collaboration:** Share modules with your team or the community. Modules make it easier for teams to collaborate on infrastructure projects. Different team members can work on separate modules independently, and then these modules can be combined to build complex infrastructure deployments. It can streamline development and reduce conflicts in the codebase.

**Testing and Validation:** Modules can be individually tested and validated, ensuring that they work correctly before being used in multiple projects. This reduces the risk of errors propagating across your infrastructure.


## Example: Using a Module

Here’s an example of how to create and use a Terraform module:

### Step 1: Create a Module
Create a directory for your module, e.g., my-vpc-module, and add the following files:

**main.tf**
```hcl

```

**variables.tf**
```hcl

```

**outputs.tf**
```hcl

```
### Step 2: Use the Module in a Root Module
In your root module directory, create the following configuration:

**main.tf:**
```hcl
provider "aws" {
  region = "us-east-1"
}

module "my_vpc" {
  source              = "./my-vpc-module"
  cidr_block          = "10.0.0.0/16"
  name                = "my-vpc"
  subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "subnet_ids" {
  value = module.my_vpc.subnet_ids
}
```

#### Module Sources
Modules can be sourced from various locations:

Local Path: source = "./my-vpc-module"
Git Repository: source = "git::<https://github.com/<terraform-aws-module/terraform-aws-module.git>"
Other Supported Sources: Such as Terraform Registry, HTTP URLs, Mercurial, Bitbucket, GCS, S3, etc.