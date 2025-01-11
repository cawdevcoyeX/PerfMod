rm -rf PeRF
git clone https://github.com/perf-project/PeRF.git
cd PeRF
apt install -y \
    git build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
    libffi-dev liblzma-dev
apt-get install libcairo2-dev
apt-get install libxml2-dev libxslt-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ..
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

bash tryperf.sh
source /root/.bashrc

source ~/.bashrc
pyenv install 3.9
pyenv global 3.9

cd PeRF

python -m pip install --upgrade "pip<24.1"
pip cache purge
pip install --no-cache-dir --force-reinstall \
    --index-url https://download.pytorch.org/whl/cu118 \
    torch torchvision torchaudio
python -m pip install --upgrade pip setuptools wheel
pip install --no-build-isolation --no-use-pep517 \
    git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

pip install ninja
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
