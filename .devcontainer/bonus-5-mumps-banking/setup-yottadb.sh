#!/bin/bash
# Optional: Install YottaDB for running the original MUMPS code
# This is not required for the challenge -- reading and translating
# the code does not need a MUMPS runtime.

set -e

echo "=== YottaDB Installation (Optional MUMPS Runtime) ==="
echo "This installs YottaDB so you can run the original MUMPS code."
echo ""

# Check if already installed
if command -v ydb &> /dev/null; then
    echo "YottaDB is already installed."
    ydb -version 2>/dev/null || true
    exit 0
fi

# Install dependencies
sudo apt-get update -qq
sudo apt-get install -y -qq binutils libelf-dev libicu-dev libjansson-dev nano wget file > /dev/null 2>&1

# Download and install YottaDB
# Pin to r1.38 -- later versions require GLIBC 2.38+ which Ubuntu 22.04 does not have.
YDBVER="r1.38"
ARCH=$(dpkg --print-architecture)
TMPDIR=$(mktemp -d)

cd "$TMPDIR"
wget -q "https://gitlab.com/YottaDB/DB/YDB/raw/master/sr_unix/ydbinstall.sh"
chmod +x ydbinstall.sh

sudo ./ydbinstall.sh --utf8 --installdir /opt/yottadb --force-install "$YDBVER" 2>/dev/null || {
    echo ""
    echo "YottaDB automatic installation failed."
    echo "You can install it manually later by following:"
    echo "  https://docs.yottadb.com/AdminOpsGuide/installydb.html"
    echo ""
    echo "The challenge does not require a running MUMPS environment."
    echo "You can read and translate the .m files without it."
    exit 0
}

rm -rf "$TMPDIR"

# Set up environment
# Disable encryption plugin -- not needed for this challenge and the shared lib is not bundled.
# Also set ydb_routines so the banking MUMPS routines are found automatically.
CHALLENGE_DIR="/workspaces/gh-copilot-for-enterprise/challenges/bonus-5-mumps-banking"
{
    echo "source /opt/yottadb/ydb_env_set"
    echo "unset ydb_crypt_config gtmcrypt_config gtm_passwd ydb_passwd 2>/dev/null"
    echo "export ydb_routines=\"$CHALLENGE_DIR/routines /opt/yottadb/libyottadbutil.so\""
} >> ~/.bashrc

echo ""
echo "YottaDB installed and configured."
echo "The ydb_routines path is set automatically in every new shell."
echo ""
echo "To start the MUMPS interpreter:"
echo "  ydb"
echo "  YDB> DO INIT^BNKINIT"
echo "  YDB> DO ^BNKMAIN"
