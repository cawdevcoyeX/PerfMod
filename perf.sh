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
apt-get install -y ffmpeg
pip install --upgrade imageio imageio-ffmpeg
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ..


bash tryperf.sh
source /root/.bashrc

source ~/.bashrc
pyenv install 3.11
pyenv global 3.11

cd PeRF

python -m pip install --upgrade "pip<24.1"
pip cache purge

pip install \
  torch==2.0.1+cu118 \
  torchvision==0.15.2+cu118 \
  torchaudio==2.0.2 \
  --index-url https://download.pytorch.org/whl/cu118

python -m pip install --upgrade pip setuptools wheel
pip install --no-build-isolation --no-use-pep517 \
    git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

pip install ninja
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

pip install --no-cache-dir -r requirements.txt

pip uninstall -y torchmetrics
pip install torchmetrics==0.10.3
apt-get install -y ffmpeg
pip install --upgrade imageio imageio-ffmpeg