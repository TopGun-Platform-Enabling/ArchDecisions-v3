terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.38.0"
    }
  }
}

provider "github" {
  owner = "scgcptigerhub"
  org = "TopGunInit"
}

resource "github_team" "arch_pt_team" {
  name        = "ArchPTTeam"
  description = "Architecture Platform Team"
  privacy     = "secret"
}

resource "github_repository_ruleset" "ghruleset" {
  name        = var.name
  repository  = "TopGunInit/SC-ArchDecisions-v3"
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
