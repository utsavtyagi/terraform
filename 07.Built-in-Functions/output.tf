output "combined_list" {
  value = concat(var.list1, var.list2)
}

output "selected_element" {
  value = element(var.os_list, 1) 
}

output "list_length" {
  value = length(var.os_list) 
}


output "joined_string" {
  value = join(", ", var.os_list)
}