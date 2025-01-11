#!/usr/bin/env bash
#
# Usage:
#   ./append_pyenv_to_bashrc.sh
#
# Description:
#   This script appends PyEnv initialization lines to ~/.bashrc.

BASHRC="$HOME/.bashrc"

cat << 'EOF' >> "$BASHRC"

# >>> pyenv setup >>>
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# <<< pyenv setup <<<
EOF

echo "Appended pyenv initialization to $BASHRC."
