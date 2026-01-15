# Use and init provider with non-deprecated versions
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.9.0"
    }
  }
}

# Configure the GitHub Provider
# ID 254608100
provider "github" {
  owner = "TopGun-Platform-Enabling"
  token = var.github_token
}

resource "github_repository_ruleset" "TigerHubv3_ruleset" {
  name        = var.name
  repository  = var.github_repository
  target      = "branch"
  enforcement = "active"

# Bypass actors (correct schema for provider v6.x)
bypass_actors {
  actor_id    = "1"
  actor_type  = "OrganizationAdmin"
  bypass_mode = "always"
}

  # Conditions block must be inside the resource
  conditions {
    ref_name {
      include = [
        "refs/heads/main",
      ]
      exclude = [
        "refs/heads/feature/*",
        "refs/heads/hotfix/*"
      ]
    }
  }

  # Rules block must also be inside the resource
  rules {
    creation            = true
    update              = true
    deletion            = true

  required_code_scanning {
      required_code_scanning_tool {
        alerts_threshold          = "errors"
        security_alerts_threshold = "high_or_higher"
        tool                      = "CodeQL"
      }
    }
  }
}
