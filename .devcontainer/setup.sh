#!/bin/bash
set -e

echo "📦 System packages..."
sudo apt-get update && sudo apt-get install -y \
  git curl wget unzip zip build-essential \
  python3 python3-pip ca-certificates gnupg lsb-release

echo "📦 Installing Node.js 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "☕ Installing Java JDK 21 (Temurin)..."
sudo mkdir -p /etc/apt/keyrings
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public \
  | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg
echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] \
  https://packages.adoptium.net/artifactory/deb \
  $(lsb_release -sc) main" \
  | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt-get update
sudo apt-get install -y temurin-21-jdk

echo "🧰 Installing SDKMAN..."
export SDKMAN_DIR="$HOME/.sdkman"
curl -s "https://get.sdkman.io" | bash
# shellcheck disable=SC1091
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "🐘 Installing Gradle 8.8..."
sdk install gradle 8.8

echo "✅ Versions:"
node -v
npm -v
java -version
gradle -v
