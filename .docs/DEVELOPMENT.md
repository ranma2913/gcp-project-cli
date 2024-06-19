# Workstation Setup

Install Deps

```
brew install go go-task
```

# Local Development

This project uses [Task](/Taskfile.yaml) to manage the development tasks. Read more about [Task](https://taskfile.dev)
for more information.
The following are the available tasks:

```shell
cd gcloud-project
task go-build
task go-run
task go-clean
```

# Initial Project Setup Steps

```shell
brew create --go \
--tap ranma2913/homebrew \
https://github.com/ranma2913/homebrew.git
```

