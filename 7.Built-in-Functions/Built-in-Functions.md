# Built-in Functions
Terraform offers a variety of built-in functions that you can utilize within your configuration files to manipulate and transform data. These functions assist in performing a range of tasks when defining your infrastructure. Here are some of the commonly used built-in functions in Terraform:

#### concat(list1, list2, ...): Combines multiple lists into a single list.
```hcl
variable "list1" {
  type    = list
  default = ["Subnet_01", "Subnet_02"]
}

variable "list2" {
  type    = list
  default = ["Subnet_03", "Subnet_04"]
}


output "combined_list" {
  value = concat(var.list1, var.list2)
}
```

#### element(list, index): Returns the element at the specified index in a list.
```hcl
variable "os_list" {
  type    = list
  default = ["Windows", "AmazonLinux", "Ubuntu"]
}


output "selected_element" {
  value = element(var.os_list, 1) 
}
```

#### length(list): Returns the number of elements in a list.
```hcl
variable "os_list" {
  type    = list
  default = ["Windows", "AmazonLinux", "Ubuntu"]
}


output "list_length" {
  value = length(var.os_list) 
}
```

#### join(separator, list): Joins the elements of a list into a single string using the specified separator.
```hcl
variable "os_list" {
  type    = list
  default = ["Windows", "AmazonLinux", "Ubuntu"]
}

output "joined_string" {
  value = join(", ", var.os_list)
}
```

These are just a few examples of the built-in functions available in Terraform. For more functions and detailed documentation, you can refer to the official Terraform documentation, which is regularly updated with new features and improvements.
