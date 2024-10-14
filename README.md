# Helper Scripts

Collection of helper scripts and scratches that I've made over time to assist with development work.

## Setup

```sh
CLONE_PATH="$HOME/devscripts"
SHELLRC="$HOME/.${SHELL##*/}rc";

git clone https://github.com/davidvogel94/helper-scripts.git $CLONE_PATH

echo "source ${CLONE_PATH%/}/bootstrap.sh" >> $SHELLRC
```

## Usage

Having sourced `bootstrap.sh`, all scripts in [./bin/](./bin) have been shimmed and can be executed from anywhere.

e.g.:

- `hetty`
- `setup_env`
- `trustcert`

### setup_env

This script is a wrapper for environment setup scripts contained within [./setup.d/](./setup.d/). E.g.:

```sh
setup_env vim postgres
setup_env postgres
setup_env --all
```
 