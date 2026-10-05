#!/bin/bash

set -e

echo "======================================"
echo " GREEN LMS DEPLOYMENT"
echo "======================================"

LMS_HOST="${LMS_HOST:-local.openedx.io}"
CMS_HOST="${CMS_HOST:-studio.local.openedx.io}"

echo ""
echo "[1] Activating Tutor environment..."

if [ -f "$HOME/tutor-venv/bin/activate" ]; then
    source "$HOME/tutor-venv/bin/activate"
else
    echo "ERROR: Tutor virtual environment not found."
    exit 1
fi

echo ""
echo "[2] Checking Tutor version..."

tutor --version

echo ""
echo "[3] Configuring Green LMS..."

tutor config save \
  --set LMS_HOST="$LMS_HOST" \
  --set CMS_HOST="$CMS_HOST" \
  --set ENABLE_HTTPS=false

echo ""
echo "[4] Starting Green LMS..."

tutor local start -d

echo ""
echo "[5] Waiting for services..."

sleep 15

echo ""
echo "[6] Checking Tutor services..."

tutor local status

echo ""
echo "[7] Checking Docker containers..."

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "[8] Testing Green LMS..."

curl -I \
  -H "Host: $LMS_HOST" \
  "http://127.0.0.1"

echo ""
echo "======================================"
echo " GREEN DEPLOYMENT VALIDATION PASSED"
echo "======================================"

echo ""
echo "Green LMS is ready for ALB validation."
echo "ALB traffic has NOT been changed by this script."
