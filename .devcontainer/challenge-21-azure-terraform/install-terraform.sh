#!/usr/bin/env bash
#
# install-terraform.sh
# Installs Terraform without using a GPG keyserver.
#
# Why this exists: the ghcr.io/devcontainers/features/terraform dev container
# feature verifies its download by fetching HashiCorp's GPG signing key from
# keyserver.ubuntu.com. In some build environments (e.g. WSL/Debian) that
# keyserver is unreachable and the build fails with:
#   "gpg: keyserver receive failed: No keyserver available"
# This script avoids that path entirely by verifying the download with the
# official SHA256SUMS checksum file instead (no GPG, no keyserver).
#
# Idempotent: if the target version is already installed, it does nothing.

set -euo pipefail

# Pin a real, current stable release published on releases.hashicorp.com.
TERRAFORM_VERSION="1.10.5"
ARCH="linux_amd64"
INSTALL_DIR="/usr/local/bin"
ZIP="terraform_${TERRAFORM_VERSION}_${ARCH}.zip"
SUMS="terraform_${TERRAFORM_VERSION}_SHA256SUMS"
BASE_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}"

echo "==> Terraform installer (target version: ${TERRAFORM_VERSION})"

# Skip if the desired version is already installed.
if command -v terraform >/dev/null 2>&1; then
	CURRENT="$(terraform version -json 2>/dev/null \
		| grep -o '"terraform_version":"[^"]*"' \
		| cut -d'"' -f4 || true)"
	if [ "${CURRENT}" = "${TERRAFORM_VERSION}" ]; then
		echo "==> Terraform ${TERRAFORM_VERSION} already installed. Nothing to do."
		exit 0
	fi
	echo "==> Found Terraform '${CURRENT:-unknown}'; replacing with ${TERRAFORM_VERSION}..."
fi

# Make sure the tools we need are available.
if ! command -v curl >/dev/null 2>&1 || ! command -v unzip >/dev/null 2>&1; then
	echo "==> Installing prerequisites (curl, unzip)..."
	sudo apt-get update -y
	sudo apt-get install -y curl unzip
fi

WORKDIR="$(mktemp -d)"
trap 'rm -rf "${WORKDIR}"' EXIT
cd "${WORKDIR}"

echo "==> Downloading ${ZIP}..."
curl -fsSL -o "${ZIP}" "${BASE_URL}/${ZIP}"

echo "==> Downloading ${SUMS}..."
curl -fsSL -o "${SUMS}" "${BASE_URL}/${SUMS}"

echo "==> Verifying SHA256 checksum (no GPG, no keyserver)..."
grep " ${ZIP}\$" "${SUMS}" | sha256sum -c -

echo "==> Installing terraform to ${INSTALL_DIR}..."
unzip -o "${ZIP}"
sudo install -m 0755 terraform "${INSTALL_DIR}/terraform"

echo "==> Installed: $(terraform version | head -n1)"
echo "==> Done."
