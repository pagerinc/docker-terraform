#!/usr/bin/env bats

@test "It should install terraform in PATH" {
  command -v terraform
}

@test "It should use terraform v0.12.0" {
  terraform --version | grep 0.12.0
}

@test "It should install awscli in PATH" {
  command -v aws
}

@test "It should use aws 1.16.76" {
  aws --version | grep 1.16.76
}

@test "It should install git in PATH" {
  command -v git
}

@test "It should include Sentry plugin in terraform" {
  ls -l $HOME/.terraform.d/plugins/linux_amd64 | grep terraform-provider-sentry
}
