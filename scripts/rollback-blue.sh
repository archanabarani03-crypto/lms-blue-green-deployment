#!/bin/bash

set -e

echo "======================================"
echo " EMERGENCY ROLLBACK: GREEN -> BLUE"
echo "======================================"

echo ""
echo "Current application state:"
echo "  Green = Current deployment"
echo "  Blue  = Previous stable deployment"

echo ""
echo "[1] Verify Blue target group is healthy"
echo ""
echo "AWS Console:"
echo "  EC2 -> Load Balancing -> Target Groups"
echo "  Open: lms-blue-tg"
echo "  Confirm Blue target status = healthy"

echo ""
echo "[2] Switch ALB traffic to Blue"
echo ""
echo "AWS Console:"
echo "  EC2 -> Load Balancers"
echo "  Open: lms-blue-green-alb"
echo "  Listeners -> HTTP :80"
echo "  Edit default action"
echo "  Select: lms-blue-tg"
echo "  Save changes"

echo ""
echo "[3] Validate Blue through ALB"

ALB_DNS="${ALB_DNS:-lms-blue-green-alb-216217372.ap-southeast-2.elb.amazonaws.com}"

curl -I \
  -H "Host: local.openedx.io" \
  "http://$ALB_DNS"

echo ""
echo "[4] Verify Blue LMS directly"

BLUE_IP="${BLUE_IP:-172.31.47.197}"

curl -I \
  -H "Host: local.openedx.io" \
  "http://$BLUE_IP"

echo ""
echo "======================================"
echo " ROLLBACK VALIDATION COMPLETED"
echo "======================================"

echo ""
echo "Expected result:"
echo "  ALB -> Blue Target Group -> Blue LMS"
echo ""
echo "Green remains available for troubleshooting."
