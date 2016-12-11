#!/usr/bin/env bats

setup() {
  echo 'foobar
foobar' | pws -bats add FOO bar
}

teardown() {
  rm -f $HOME/.pws-bats
}

@test "It should install the ruby-keychain gem" {
  run gem list ruby-keychain
  [[ ! "$output" =~ "ruby-keychain" ]]
}

@test "It should print secrets via omnivault env" {
  run bash -c "echo foobar | omnivault env -v bats"
  echo $output > $HOME/bats.out
  [[ "$output" =~ "FOO=bar" ]]
}

@test "It should run a shell with secrets in ENV via omnivault exec" {
  run bash -c "echo foobar | omnivault exec -v bats env"
  [[ "$output" =~ "FOO=bar" ]]
}
