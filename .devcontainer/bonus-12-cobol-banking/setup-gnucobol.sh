#!/bin/bash
# Optional: Install GnuCOBOL for compiling and running the original COBOL code
# This is not required for the challenge -- reading and translating
# the code does not need a COBOL compiler.

set -e

echo "=== GnuCOBOL Installation (COBOL Compiler) ==="

# Check if already installed
if command -v cobc &> /dev/null; then
    echo "GnuCOBOL is already installed."
    cobc --version 2>/dev/null | head -1 || true
    exit 0
fi

# Install GnuCOBOL from package manager
sudo apt-get update -qq
sudo apt-get install -y -qq gnucobol > /dev/null 2>&1 || {
    echo ""
    echo "GnuCOBOL installation failed."
    echo "You can install it manually: sudo apt-get install gnucobol"
    echo ""
    echo "The challenge does not require a running COBOL environment."
    echo "You can read and translate the .cbl files without it."
    exit 0
}

# Verify installation
echo "GnuCOBOL installed successfully:"
cobc --version | head -1

# Create data directory for ISAM files
CHALLENGE_DIR="/workspaces/gh-copilot-for-enterprise/challenges/bonus-12-cobol-banking"
mkdir -p "$CHALLENGE_DIR/data"

echo ""
echo "To compile the banking system:"
echo "  cd $CHALLENGE_DIR"
echo "  cobc -x -free programs/BNKINIT.cbl"
echo "  ./BNKINIT"
echo "  cobc -x -free programs/BNKMAIN.cbl"
echo "  ./BNKMAIN"
echo ""
echo "See docs/running-the-app.md for full instructions."
