#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
dotnet build EquipmentBooking.sln --configuration Release --nologo
dotnet test EquipmentBooking.sln --configuration Release --no-build --no-restore --nologo
