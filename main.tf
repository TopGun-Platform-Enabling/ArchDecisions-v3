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
provider "github" {
  owner = "TopGunInit"
  token = var.github_token
}

resource "github_membership" "membership_for_user_x" {
  username = "scgcptigerhub"
  role     = "admin"
}

resource "github_repository_ruleset" "ghruleset" {
  name        = var.name
  repository  = "SC-ArchDecisions-v3"
  target      = "push"
  enforcement = "disabled"

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
    update = true
    update_allows_fetch_and_merge = true

    required_status_checks {
      strict_required_status_checks_policy = false
      do_not_enforce_on_create             = true

      required_check {
        context        = "terraform"
        integration_id = 0
      }

      required_check {
        context        = "tests"
        integration_id = 0
      }
    }
  }
}
