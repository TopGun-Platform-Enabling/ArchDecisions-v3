# Use and init provider with non-deprecated versions
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
# ID 254608100
provider "github" {
  owner = "TopGun-Platform-Enabling"
  token = var.github_token
}

#resource "github_membership" "membership_for_user_x" {
#  username = "scgcptigerhub"
#  role     = "admin"
#  depends_on = [github_repository.ArchDecisions-v3]}

resource "github_repository_ruleset" "TigerHubv3_ruleset" {
  name        = var.name
  repository  = "ArchDecisions-v3"
  target      = "branch"
  enforcement = "active"

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

  rules {
    rules {
    creation                = true
    update                  = true
    deletion                = true
    required_signatures     = true

    required_deployments {
      required_deployment_environments = [" "]
    }

    required_code_scanning {
      required_code_scanning_tool {
        alerts_threshold          = "errors"
        security_alerts_threshold = "high_or_higher"
        tool                      = "CodeQL"
      }
    }
  }
}
  depends_on = [github_repository.ArchDecisions-v3]
}
