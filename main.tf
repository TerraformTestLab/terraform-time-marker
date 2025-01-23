terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

provider "time" {}

# Generate a rotating resource based on time
resource "time_rotating" "unique_rotator" {
  rotation_minutes = 1
}

# Create a static resource with timestamp
resource "time_static" "execution_timestamp" {}

output "rotation_timestamp" {
  value       = time_rotating.unique_rotator.id
  description = "A unique identifier that rotates every minute"
}

output "execution_moment" {
  value       = time_static.execution_timestamp.rfc3339
  description = "Precise timestamp of Terraform execution"
}

output "unique_signature" {
  value       = "${time_rotating.unique_rotator.id}-${time_static.execution_timestamp.unix}"
  description = "Combined unique identifier using rotation and static time"
}
