#!/usr/bin/env bash
set -o errexit #abort if any command fails

run_build() {
  bundle exec middleman build --clean
}

deploy() {
  rsync -av build abuse:docs
}

if [[ $1 = --source-only ]]; then
  run_build
elif [[ $1 = --push-only ]]; then
  deploy
else
  run_build
  deploy
fi
