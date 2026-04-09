#!/bin/bash
# deploy.sh - manual deployment script
# Usage: ./deploy.sh [staging|production]
# Last updated: 2023-04-12 by someone who left

ENV=${1:-staging}

echo "=== Deploying to $ENV ==="

# Build API
echo "Building API..."
cd api-service
npm install
# no tests, just ship it
cd ..

# Build web app
echo "Building web app..."
# it's static HTML, nothing to build

# Deploy
if [ "$ENV" = "staging" ]; then
    echo "Deploying to staging server..."
    # scp -r api-service/ staging-server:/opt/taskboard/api/
    # scp -r web-app/ staging-server:/opt/taskboard/web/
    # ssh staging-server "cd /opt/taskboard/api && pm2 restart taskboard-api"
    echo "(deploy commands are commented out -- run them manually)"
elif [ "$ENV" = "production" ]; then
    echo "Deploying to production..."
    echo "WARNING: make sure staging is green first!"
    echo "WARNING: there are no automated tests!"
    # scp -r api-service/ prod-server:/opt/taskboard/api/
    # scp -r web-app/ prod-server:/opt/taskboard/web/
    # ssh prod-server "cd /opt/taskboard/api && pm2 restart taskboard-api"
    echo "(deploy commands are commented out -- edit this script with real server details)"
fi

echo "=== Done ==="
