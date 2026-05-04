#!/bin/bash
set -e

echo "=========================================="
echo "Setting up Challenge 19 - WCF Banking Modernization"
echo "=========================================="

if ! command -v dotnet &>/dev/null; then
    echo "ERROR: .NET SDK not found"
    exit 1
fi

echo ".NET SDK version: $(dotnet --version)"

CHALLENGE_PATH="/workspaces/gh-copilot-for-enterprise/challenges/challenge-19-wcf-banking"
if [ -d "$CHALLENGE_PATH" ]; then
    echo "Restoring NuGet packages..."
    cd "$CHALLENGE_PATH"
    dotnet restore challenge-19-wcf-banking.sln || {
        echo "WARNING: dotnet restore had issues -- continuing"
    }
else
    echo "WARNING: Challenge folder not found at $CHALLENGE_PATH"
fi

echo "=========================================="
echo "CoreWCF environment ready"
echo "=========================================="
echo ""
echo "To start the service:"
echo "  cd challenges/challenge-19-wcf-banking"
echo "  dotnet run --project src/Meridian.Banking.Service"
echo ""
echo "Endpoints will be available at:"
echo "  http://localhost:5000/AccountService"
echo "  http://localhost:5000/LoanService"
echo "  http://localhost:5000/TransactionService"
