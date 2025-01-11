echo "In workspace"
apt-get update
apt-get upgrade
apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
service docker start
apt-get install -y build-essential gcc g++ git
rm -rf instant-ngp/
git clone https://github.com/NVlabs/instant-ngp.git
cd instant-ngp
git submodule update --init --recursive
wget https://github.com/Kitware/CMake/releases/download/v3.27.2/cmake-3.27.2.tar.gz
tar -xf cmake-3.27.2.tar.gz
cd cmake-3.27.2
apt-get install -y libssl-dev
./bootstrap
make -j
make install
cd ../
rm -rf build
mkdir build
apt-get install -y libx11-dev
apt-get install -y mesa-common-dev
apt-get install -y build-essential git python3-dev python3-pip libopenexr-dev libxi-dev libglfw3-dev libglew-dev libomp-dev libxinerama-dev libxcursor-dev
apt-get install -y libxrandr-dev
cmake -B build .
cmake --build build --config RelWithDebInfo -j `nproc`
pip install commentjson
pip install imageio
pip install scipy
pip install -r requirements.txt
apt install -y x11-apps
apt install -y xauth xorg



#!/bin/bash

# Define the file to modify
CONFIG_FILE="/etc/ssh/sshd_config"

# Define the lines to add or update
LINES_TO_ADD=(
    "X11Forwarding yes"
    "X11DisplayOffset 10"
    "X11UseLocalhost yes"
)

# Backup the original configuration file
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

# Loop through each line and ensure it's in the file
for LINE in "${LINES_TO_ADD[@]}"; do
    # Check if the line exists
    if grep -q "^${LINE}" "$CONFIG_FILE"; then
        echo "Line already exists: $LINE"
    else
        # Add the line if it doesn't exist
        echo "$LINE" >> "$CONFIG_FILE"
        echo "Added line: $LINE"
    fi
done

# Restart the SSH service for non-systemctl systems
if command -v service > /dev/null; then
    # Use 'service' command
    service ssh restart
elif command -v /etc/init.d/ssh > /dev/null; then
    # Use init script directly
    /etc/init.d/ssh restart
else
    echo "Could not restart SSH service. Please restart it manually."
    exit 1
fi

echo "X11 forwarding configuration updated and SSH service restarted."




apt-get install -y x2goserver x2goserver-xsession
apt-get install -y xfce4 xfce4-goodies
adduser ekc
usermod -aG sudo ekc
apt-get install -y x2goclient
