#!/bin/bash
set -e

echo "📦 System packages..."
sudo apt update && sudo apt install -y \
  git curl wget unzip zip build-essential \
  python3 python3-pip ca-certificates gnupg lsb-release

echo "📦 Installing Node.js 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "☕ Installing Java JDK 21..."
sudo apt install -y openjdk-21-jdk

echo "🧰 Installing SDKMAN..."
export SDKMAN_DIR="$HOME/.sdkman"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "🐘 Installing Gradle..."
sdk install gradle 8.8

echo "✅ Versions:"
node -v && npm -v && java -version && gradle -v
