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
#  depends_on = [github_repository.ArchDecisions-v3]
#}

resource "github_repository_ruleset" "TigerHubv3_ruleset" {
  name        = var.name
  repository  = "ArchDecisions-v3"
  target      = "branch"
  enforcement = "active"

  bypass_actors {
      actor_id = "1"
      type   = "users"
      bypass_mode = "always"
    }

  bypass_actors {
      actor_id = "5"
      type   = "teams"
      bypass_mode = "pull_requests_only"
    }
  }
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

resource "github_repository" "ArchDecisions-v3" {
  name        = "ArchDecisions-v3"
  description = "Architecture Decision Records for TopGun Platform Enabling Team - v3"
  visibility  = "private"
  has_issues  = true
  has_wiki    = false
  has_projects = false
} 

resource "github_branch" "main_branch" {
  repository = github_repository.ArchDecisions-v3.name
  branch     = "main"
  depends_on = [github_repository.ArchDecisions-v3]
}

