# .tfvars file

Terraform allows you to define variable files called *.tfvars to create a reusable file for all the variables for a project.

In Terraform, .tfvars files, usually identified by their .tfvars extension, are utilized to assign particular values to input variables outlined in your Terraform configuration. These files enable the segregation of configuration values from your Terraform code, simplifying the management of diverse configurations for various environments (like development, staging, and production) or facilitating the storage of sensitive information without its exposure in your code.

#### Here's a basic example of what a .tfvars file might look like:
```hcl
aws_region = "us-west-2"
ami_id = "ami-0b20a6f09484773af"
instance_type = "t2.micro"
key_name = "demo_config_key_us"
security_group_id = "sg-00f1906a3bb9a9383"
subnet_id = "subnet-c6b4b7bf"
instance_name = "ExampleInstance"
```

In this example, aws_region, ami_id, instance_type,  key_name, security_group_id, subnet_id, and instance_name are variables that might be used in a Terraform configuration. By defining these values in a .tfvars file, you can easily reuse this file across different environments or configurations.

#### When you apply your Terraform configuration, you can specify the .tfvars file using the -var-file flag:
```powershell
terraform apply -var-file=terraform.tfvars
```

