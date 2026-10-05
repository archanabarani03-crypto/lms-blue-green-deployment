#!/bin/bash

set -e

echo "======================================"
echo " LMS BLUE-GREEN HEALTH CHECK"
echo "======================================"

LMS_HOST="${LMS_HOST:-local.openedx.io}"
LMS_IP="${LMS_IP:-172.31.43.211}"

echo ""
echo "[1] Activating Tutor environment..."

if [ -f "$HOME/tutor-venv/bin/activate" ]; then
    source "$HOME/tutor-venv/bin/activate"
else
    echo "ERROR: Tutor virtual environment not found."
    exit 1
fi

echo ""
echo "[2] Checking Tutor services..."

tutor local status

echo ""
echo "[3] Checking Docker containers..."

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "[4] Checking LMS through Green private IP..."

curl -I \
  -H "Host: $LMS_HOST" \
  "http://$LMS_IP"

echo ""
echo "======================================"
echo " HEALTH CHECK COMPLETED"
echo "======================================"
