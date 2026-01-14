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

<<<<<<< HEAD
#resource "github_membership" "membership_for_user_x" {
 # username = "scgcptigerhub"
 # role     = "admin"
#}
=======
>>>>>>> dcead9d479b9b1f590f3e21158809fdc917f8cb9

resource "github_repository_ruleset" "TigerHubv2" {
  name        = var.name
  repository  = "ArchDecisions-v3"
  target      = "push"
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
    update = true
    update_allows_fetch_and_merge = true

    required_status_checks {
      strict_required_status_checks_policy = false
      do_not_enforce_on_create             = false

      required_check {
        context        = "terraform"
        integration_id = 254608100
      }

      required_check {
        context        = "tests"
        integration_id = 254608100
      }
    }
  }
}
