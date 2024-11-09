# Helper Scripts

Collection of helper scripts and scratches that I've made over time to assist with development work.

## Setup

```sh
CLONE_PATH="$HOME/scripts"
SHELLRC="$HOME/.${SHELL##*/}rc";

git clone https://github.com/davidvogel94/helper-scripts.git $CLONE_PATH

echo "source ${CLONE_PATH%/}/bootstrap.sh" >> $SHELLRC
```

## Usage

Having sourced `bootstrap.sh`, all scripts in [./bin/](./bin) have been shimmed and can be executed from anywhere.

e.g.:

- `hetty`
- `reconfigure`
- `trustcert`

### setup_env

This script is a wrapper for environment setup scripts contained within [./setup-scripts/](./setup-scripts/). E.g.:

```sh
reconfigure vim vscode
reconfigure postgres-eas
reconfigure --all
```
 