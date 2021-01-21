# Automated self-hosted Github Actions runner ![Run runner](https://github.com/wzieba/RunSelfHostedRunner/workflows/Run%20runner/badge.svg)

This set of scripts automates instalation, token generation, configuration and run of the self-hosted Github Action runner

Highly inspired by https://github.com/myoung34/docker-github-actions-runner/

## Requirements

This script requires [`jq`](https://github.com/stedolan/jq) (to read Github API response with token)

It's also designed to work on macOS, but you can easily change it in `install_actions.sh`

## Usage

```
./entrypoint.sh --token <token> --repo https://github.com/user/repo --name "My cool runner"
```

## Token type

Token will be used to dynamically fetch a new **runner** token, as runner tokens are valid for a short period.

Your PAT should have **repo scopes**.

(this description is partialy taken from https://github.com/tcardonne/docker-github-runner#runner-token)

