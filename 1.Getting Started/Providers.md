# Providers

Providers are a logical abstraction of an upstream API. They are responsible for understanding API interactions and exposing resources.

## AWS Provider

The AWS provider enables interaction with the vast array of resources offered by Amazon Web Services (AWS). Before using this provider, you must configure it with the appropriate credentials.

### Example Usage

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```
### Configuration of the AWS Provider
The following example demonstrates how to configure the AWS provider with a specific region:
```hcl
hcl
Copy code
provider "aws" {
  region = "us-east-1"
}
```