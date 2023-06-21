variable "log_analytics_workspace_id" {
  description = "The Azure resource ID of the Analytics Workspace"
  type        = string

  validation {
    condition     = length(regexall("^\\/subscriptions\\/[a-z0-9\\-]+\\/resourceGroups\\/[a-z0-9\\-]+\\/providers\\/Microsoft\\.OperationalInsights\\/workspaces\\/[a-z0-9\\-]+$", var.log_analytics_workspace_id)) == 1
    error_message = "Not a valid azure resoure ID for a workspace"
  }
}

# Optional variables

variable "name_suffix" {
  description = "What to suffix all the Azure Resource names with. E.g. 'prod-1'"
  type        = string
  default     = "prod-1"

  validation {
    condition     = length(regexall("^[a-z0-9]+(\\-[a-z0-9]+)*$", var.name_suffix)) == 1
    error_message = "Must only contain lowercase leters, number and hyphens. Can't start or end with a hyphen and two characters or longer"
  }
}

variable "tags" {
  description = "The tags to add to all of the azure resources"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "The Azure Region to deploy into"
  type        = string
  default     = "australiaeast"
}