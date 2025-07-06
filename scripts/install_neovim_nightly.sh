#!/usr/bin/env bash

set -euo pipefail

# Configuration
OS="$(uname -s)"
ARCH="$(uname -m)"
EXTRACT_PATH="/tmp/nvim-extract-$$"
TAR_PATH="/tmp/nvim-nightly-$$.tar.gz"

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Cleanup function
cleanup() {
    local exit_code=$?
    [[ -f "$TAR_PATH" ]] && rm -f "$TAR_PATH"
    [[ -d "$EXTRACT_PATH" ]] && rm -rf "$EXTRACT_PATH"
    exit $exit_code
}

# Set trap for cleanup
trap cleanup EXIT INT TERM

# Determine install location based on permissions
if [[ -w "/usr/local/bin" ]] && [[ -w "/usr/local" ]]; then
    # User has write access to /usr/local
    INSTALL_PREFIX="/usr/local"
elif [[ "$HOME" == "/root" ]] || [[ "${SUDO_USER:-}" != "" ]]; then
    # Running as root or with sudo
    INSTALL_PREFIX="/usr/local"
else
    # Need to use user directory
    INSTALL_PREFIX="$HOME/.local"
    # Ensure ~/.local/bin exists
    mkdir -p "$HOME/.local/bin"
fi

BIN_DIR="$INSTALL_PREFIX/bin"
LIB_DIR="$INSTALL_PREFIX/lib/nvim-nightly"
SHARE_DIR="$INSTALL_PREFIX/share/nvim-nightly"

# Determine download URL based on OS and architecture
case "$OS" in
    Darwin)
        if [[ "$ARCH" == "arm64" ]]; then
            DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz"
            ARCHIVE_NAME="nvim-macos-arm64"
        else
            DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz"
            ARCHIVE_NAME="nvim-macos-x86_64"
        fi
        ;;
    Linux)
        if [[ "$ARCH" == "x86_64" ]]; then
            DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
            ARCHIVE_NAME="nvim-linux64"
        else
            echo -e "${RED}Unsupported Linux architecture: $ARCH${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}Unsupported OS: $OS${NC}"
        exit 1
        ;;
esac

echo -e "\n${CYAN}Neovim Nightly Installer${NC}"
echo -e "${CYAN}========================${NC}\n"
echo -e "${GREEN}Installing to: $INSTALL_PREFIX${NC}"

# Check for required commands
for cmd in curl tar; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}Error: $cmd is required but not installed${NC}"
        exit 1
    fi
done

# Remove existing installation
echo -e "${YELLOW}Checking for existing installation...${NC}"
[[ -f "$BIN_DIR/nvin" ]] && rm -f "$BIN_DIR/nvin"
[[ -f "$BIN_DIR/nvin.real" ]] && rm -f "$BIN_DIR/nvin.real"
[[ -d "$LIB_DIR" ]] && rm -rf "$LIB_DIR"
[[ -d "$SHARE_DIR" ]] && rm -rf "$SHARE_DIR"

# Download with retry
echo -e "${GREEN}Downloading Neovim nightly for $OS $ARCH...${NC}"
RETRY_COUNT=3
for ((i=1; i<=RETRY_COUNT; i++)); do
    if curl -fsSL -o "$TAR_PATH" "$DOWNLOAD_URL"; then
        break
    else
        if [[ $i -eq $RETRY_COUNT ]]; then
            echo -e "${RED}Download failed after $RETRY_COUNT attempts${NC}"
            exit 1
        fi
        echo -e "${YELLOW}Download attempt $i failed, retrying...${NC}"
        sleep 2
    fi
done

# Verify download
if [[ ! -f "$TAR_PATH" ]]; then
    echo -e "${RED}Download file not found${NC}"
    exit 1
fi

FILE_SIZE=$(stat -f%z "$TAR_PATH" 2>/dev/null || stat -c%s "$TAR_PATH" 2>/dev/null || echo 0)
if [[ $FILE_SIZE -lt 1000000 ]]; then  # Less than 1MB is suspicious
    echo -e "${RED}Downloaded file is too small: $FILE_SIZE bytes${NC}"
    exit 1
fi

# Extract to temp location
echo -e "${GREEN}Extracting files...${NC}"
mkdir -p "$EXTRACT_PATH"
if ! tar -xzf "$TAR_PATH" -C "$EXTRACT_PATH" 2>/dev/null; then
    echo -e "${RED}Extraction failed - corrupt or invalid archive${NC}"
    exit 1
fi

# Find the extracted directory (more flexible approach)
NVIM_SOURCE_PATH=""
for dir in "$EXTRACT_PATH"/*; do
    if [[ -d "$dir" ]] && [[ -f "$dir/bin/nvim" ]]; then
        NVIM_SOURCE_PATH="$dir"
        break
    fi
done

if [[ -z "$NVIM_SOURCE_PATH" ]]; then
    echo -e "${RED}Could not find nvim binary in extracted files${NC}"
    echo -e "${GRAY}Archive structure:${NC}"
    find "$EXTRACT_PATH" -type f -name "nvim" 2>/dev/null || echo "No nvim binary found"
    exit 1
fi

echo -e "${GREEN}Found Neovim in: $(basename "$NVIM_SOURCE_PATH")${NC}"

# Create directories
mkdir -p "$BIN_DIR" "$LIB_DIR" "$SHARE_DIR" || {
    echo -e "${RED}Failed to create installation directories${NC}"
    exit 1
}

# Copy files preserving structure
echo -e "${GREEN}Installing files...${NC}"

# Copy lib files if they exist
if [[ -d "$NVIM_SOURCE_PATH/lib" ]]; then
    cp -r "$NVIM_SOURCE_PATH/lib/"* "$LIB_DIR/" 2>/dev/null || true
fi

# Copy share files if they exist
if [[ -d "$NVIM_SOURCE_PATH/share" ]]; then
    cp -r "$NVIM_SOURCE_PATH/share/"* "$SHARE_DIR/" 2>/dev/null || true
fi

# Copy binary
if ! cp "$NVIM_SOURCE_PATH/bin/nvim" "$BIN_DIR/nvin.real"; then
    echo -e "${RED}Failed to copy nvim binary${NC}"
    exit 1
fi
chmod +x "$BIN_DIR/nvin.real"

# Create wrapper script with proper quoting
cat > "$BIN_DIR/nvin" << 'EOF'
#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_PREFIX="$(dirname "$SCRIPT_DIR")"
export VIM="$INSTALL_PREFIX/share/nvim-nightly/runtime"
export VIMRUNTIME="$INSTALL_PREFIX/share/nvim-nightly/runtime"
exec "$SCRIPT_DIR/nvin.real" "$@"
EOF

chmod +x "$BIN_DIR/nvin"

# Verify installation works
echo -e "${GREEN}Verifying installation...${NC}"
if ! "$BIN_DIR/nvin" --version &>/dev/null; then
    echo -e "${RED}Installation verification failed${NC}"
    echo -e "${GRAY}Trying to run: $BIN_DIR/nvin --version${NC}"
    "$BIN_DIR/nvin" --version 2>&1 || true
    exit 1
fi

# Check if ~/.local/bin needs to be added to PATH
if [[ "$INSTALL_PREFIX" == "$HOME/.local" ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "\n${YELLOW}ACTION REQUIRED: Add $HOME/.local/bin to your PATH${NC}"
    
    SHELL_NAME="$(basename "${SHELL:-/bin/bash}")"
    RC_FILE=""
    
    case "$SHELL_NAME" in
        bash)
            RC_FILE="${BASH_ENV:-$HOME/.bashrc}"
            [[ "$OS" == "Darwin" ]] && RC_FILE="$HOME/.bash_profile"
            ;;
        zsh)
            RC_FILE="${ZDOTDIR:-$HOME}/.zshrc"
            ;;
        fish)
            RC_FILE="$HOME/.config/fish/config.fish"
            ;;
        *)
            RC_FILE="$HOME/.profile"
            ;;
    esac
    
    echo -e "${GRAY}Add this line to $RC_FILE:${NC}"
    
    if [[ "$SHELL_NAME" == "fish" ]]; then
        echo -e "${CYAN}set -gx PATH \$HOME/.local/bin \$PATH${NC}"
    else
        echo -e "${CYAN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    fi
    
    echo -e "${GRAY}Then run: source $RC_FILE${NC}"
fi

# Final status
echo -e "\n${GREEN}Installation complete!${NC}"
echo -e "${GRAY}Binary: $BIN_DIR/nvin${NC}"
echo -e "${GRAY}Command: nvin${NC}"

VERSION=$("$BIN_DIR/nvin" --version 2>&1 | head -n 1)
echo -e "${GRAY}Version: $VERSION${NC}"

# Success - cleanup handled by trap
exit 0
