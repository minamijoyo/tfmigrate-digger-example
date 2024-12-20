An example for [tfmigrate](https://github.com/minamijoyo/tfmigrate) with [Digger](https://github.com/diggerhq/digger)

This repository contains all configurations for running Digger in GitHub Actions + AWS, but most of them are actually not related to tfmigrate. To use tfmigrate with Digger:

- Configure tfmigrate in [.tfmigrate.hcl](.tfmigrate.hcl).
- Add a custom workflow for tfmigrate in [digger_tfmigrate.yml](digger_tfmigrate.yml).
- Install tfmigrate and replace digger.yml dynamically in [.github/scripts/pre_workflow_hooks.sh](.github/scripts/pre_workflow_hooks.sh).
- Run pre_workflow_hooks.sh before the digger is executed in [.github/workflows/digger_workflow.yml](.github/workflows/digger_workflow.yml).

Note: If you use [OpenTofu](https://github.com/opentofu/opentofu), a community fork of Terraform, you also need to set the environment variable `TFMIGRATE_EXEC_PATH` to `tofu` in GitHub Actions.
