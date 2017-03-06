#!/usr/bin/env bats

setup() {
  security create-keychain -p foobar omnivault-bats.keychain
  security add-generic-password -A -a FOO -s FOO -w bar omnivault-bats.keychain
  security unlock-keychain -p foobar omnivault-bats.keychain
}

teardown() {
  rm -f $HOME/Library/Keychains/omnivault-bats.keychain
}

@test "It should install the ruby-keychain gem" {
  run gem list ruby-keychain
  [[ "$output" =~ "ruby-keychain" ]]
}

@test "It should print secrets via omnivault env" {
  run omnivault env -v bats
  [[ "$output" =~ "FOO=bar" ]]
}

@test "It should run a shell with secrets in ENV via omnivault exec" {
  run omnivault exec -v bats env
  [[ "$output" =~ "FOO=bar" ]]
}
