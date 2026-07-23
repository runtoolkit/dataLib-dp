#!/bin/bash
set -e
mkdir -p .vscode && cat << 'EOF' > .vscode/settings.json
{
  "groovy.classpath": [
    "."
  ],
  "files.associations": {
    "*.gradle": "groovy"
  }
}
EOF

# ── Package manager detection ─────────────────────────────────────────
for PM in apt-get apt yum dnf apk; do
  if command -v "$PM" &>/dev/null; then PKG="$PM"; break; fi
done
if [ -z "$PKG" ]; then
  echo "❌ No package manager found!" >&2
  exit 1
fi
echo "📦 Package manager: $PKG"

# ── sudo detection ────────────────────────────────────────────────────
SUDO=""
command -v sudo &>/dev/null && SUDO="sudo"

# ── PATH helper ───────────────────────────────────────────────────────
append_path() {
  local DIR="$1"
  local MARKER="# path:$DIR"
  for RC in "$HOME/.bashrc" "$HOME/.profile"; do
    [ -f "$RC" ] || touch "$RC"
    grep -qF "$MARKER" "$RC" 2>/dev/null && continue
    printf '\n%s\nexport PATH="%s:$PATH"\n' "$MARKER" "$DIR" >> "$RC"
  done
  export PATH="$DIR:$PATH"
}

append_env() {
  local LINE="$1"
  local MARKER="$2"
  for RC in "$HOME/.bashrc" "$HOME/.profile"; do
    [ -f "$RC" ] || touch "$RC"
    grep -qF "$MARKER" "$RC" 2>/dev/null && continue
    printf '\n%s\n' "$LINE" >> "$RC"
  done
}

# ── System packages ───────────────────────────────────────────────────
echo "📦 Installing system packages..."
if [ "$PKG" = "apk" ]; then
  $SUDO apk update && $SUDO apk add --no-cache \
    git curl wget unzip zip build-base \
    python3 py3-pip ca-certificates gnupg coreutils bash \
    jq git-lfs python3-venv diffutils patch file shellcheck
else
  $SUDO $PKG update -y && $SUDO $PKG install -y \
    git curl wget unzip zip build-essential \
    python3 python3-pip python3-venv ca-certificates gnupg lsb-release \
    jq git-lfs diffutils patch file shellcheck
fi

# ── Git LFS init ──────────────────────────────────────────────────────
echo "🗂  Initializing Git LFS..."
git lfs install --system 2>/dev/null || git lfs install

# ── Node.js 20 ────────────────────────────────────────────────────────
echo "📦 Installing Node.js 20..."
if command -v node &>/dev/null; then
  echo "  Already installed: $(node -v)"
else
  wget -q -O /tmp/node.tar.gz \
    "https://nodejs.org/dist/v20.20.2/node-v20.20.2-linux-x64.tar.gz"
  $SUDO tar -xzf /tmp/node.tar.gz -C /usr/local --strip-components=1
  rm /tmp/node.tar.gz
fi

# ── Java 21 (Temurin binary) ──────────────────────────────────────────
echo "☕ Installing Java JDK 21..."
if [ ! -f "/opt/jdk21/bin/java" ]; then
  wget -q -O /tmp/jdk21.tar.gz \
    "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.7%2B6/OpenJDK21U-jdk_x64_linux_hotspot_21.0.7_6.tar.gz"
  $SUDO mkdir -p /opt/jdk21
  $SUDO tar -xzf /tmp/jdk21.tar.gz -C /opt/jdk21 --strip-components=1
  rm /tmp/jdk21.tar.gz
else
  echo "  Already installed: $(/opt/jdk21/bin/java -version 2>&1 | head -1)"
fi
export JAVA_HOME=/opt/jdk21
append_path "/opt/jdk21/bin"
append_env "export JAVA_HOME=/opt/jdk21" "JAVA_HOME=/opt/jdk21"

# ── Gradle 8.8 (direct binary) ────────────────────────────────────────
echo "🐘 Installing Gradle 8.8..."
if [ ! -f "/opt/gradle/bin/gradle" ]; then
  wget -q -O /tmp/gradle.zip \
    "https://services.gradle.org/distributions/gradle-8.8-bin.zip"
  $SUDO mkdir -p /tmp/gradle-extract /opt/gradle
  $SUDO unzip -q /tmp/gradle.zip -d /tmp/gradle-extract
  $SUDO cp -r /tmp/gradle-extract/gradle-8.8/. /opt/gradle/
  $SUDO rm -rf /tmp/gradle-extract /tmp/gradle.zip
else
  echo "  Already installed: $(/opt/gradle/bin/gradle -v | grep Gradle)"
fi
append_path "/opt/gradle/bin"

# ── SDKMAN ────────────────────────────────────────────────────────────
echo "🧰 Installing SDKMAN..."
export SDKMAN_DIR="${SDKMAN_DIR:-$HOME/.sdkman}"
if [ ! -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  curl -s "https://get.sdkman.io" | bash
fi
# shellcheck disable=SC1091
source "$SDKMAN_DIR/bin/sdkman-init.sh" || true
append_env \
  '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' \
  'sdkman-init.sh'

# ── Done ──────────────────────────────────────────────────────────────
echo ""
echo "✅ Versions:"
node -v
npm -v
/opt/jdk21/bin/java -version
/opt/gradle/bin/gradle -v | grep Gradle
jq --version
shellcheck --version | head -1
git lfs version
