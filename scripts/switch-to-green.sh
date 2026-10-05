#!/bin/bash

set -e

echo "======================================"
echo " ALB SWITCH: BLUE -> GREEN"
echo "======================================"

# Set these values before running the script
LISTENER_ARN="${LISTENER_ARN:-}"
GREEN_TG_ARN="${GREEN_TG_ARN:-}"

if [ -z "$LISTENER_ARN" ]; then
    echo "ERROR: LISTENER_ARN is not set."
    echo "Example:"
    echo "export LISTENER_ARN='arn:aws:elasticloadbalancing:REGION:ACCOUNT:listener/app/NAME/ID/ID'"
    exit 1
fi

if [ -z "$GREEN_TG_ARN" ]; then
    echo "ERROR: GREEN_TG_ARN is not set."
    echo "Example:"
    echo "export GREEN_TG_ARN='arn:aws:elasticloadbalancing:REGION:ACCOUNT:targetgroup/lms-green-tg/ID'"
    exit 1
fi

echo ""
echo "[1] Checking AWS CLI..."

aws --version

echo ""
echo "[2] Checking Green target group..."

aws elbv2 describe-target-health \
  --target-group-arn "$GREEN_TG_ARN"

echo ""
echo "[3] Switching ALB traffic to Green..."

aws elbv2 modify-listener \
  --listener-arn "$LISTENER_ARN" \
  --default-actions Type=forward,TargetGroupArn="$GREEN_TG_ARN"

echo ""
echo "[4] Verifying ALB listener..."

aws elbv2 describe-listeners \
  --listener-arns "$LISTENER_ARN" \
  --query 'Listeners[0].DefaultActions'

echo ""
echo "======================================"
echo " BLUE -> GREEN CUTOVER COMPLETED"
echo "======================================"
