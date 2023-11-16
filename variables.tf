##############
# Basic Group
##############

# @group "Basic"
# @label "Source"
variable "source_address" {
  type        = string
  description = "Specify the seeding source address started with 'file://' or 'http(s)://' schema, such as: https://raw.githubusercontent.com/seal-io/terraform-provider-byteset/main/byteset/testdata/mysql.sql."

  validation {
    condition     = can(regex("^(?:(https|http|file)://)+(?:[^/.\\s]+\\.)*", var.source_address))
    error_message = "Invalid source address"
  }
}

# @group "Basic"
# @label "Destination"
variable "destination_address" {
  type        = string
  description = "Specify the seeding destiantion address, please refer to: https://github.com/seal-io/terraform-provider-byteset/blob/main/docs/resources/pipeline.md#nested-schema-for-destination."
}

#################
# Advanced Group
#################

# @group "Advanced"
# @label "Destination Connection Maximum"
variable "destination_conn_max" {
  type        = number
  description = "Specify the connection maximum value of destination."
  default     = 5

  validation {
    condition     = var.destination_conn_max > 0
    error_message = "Invalid destination connection maximum value"
  }
}

# @group "Advanced"
# @label "Destination Batch Capacity"
variable "destination_batch_cap" {
  type        = number
  description = "Specify the (insertion) batch capacity value of destination."
  default     = 500

  validation {
    condition     = var.destination_batch_cap > 0
    error_message = "Invalid destination (insertion) batch capacity value"
  }
}

###########################
# Injection Group (Hidden)
###########################

# @hidden
variable "walrus_metadata_project_name" {
  type        = string
  description = "Walrus metadata project name."
  default     = ""
}

# @hidden
variable "walrus_metadata_environment_name" {
  type        = string
  description = "Walrus metadata environment name."
  default     = ""
}

# @hidden
variable "walrus_metadata_service_name" {
  type        = string
  description = "Walrus metadata service name."
  default     = ""
}

# @hidden
variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}
