#!/bin/bash

echo "======================================"
echo " LMS BLUE-GREEN ALB SWITCH"
echo "======================================"

echo ""
echo "ALB: lms-blue-green-alb"
echo "Listener: HTTP :80"

echo ""
echo "BLUE:"
echo "Target Group: lms-blue-tg"

echo ""
echo "GREEN:"
echo "Target Group: lms-green-tg"

echo ""
echo "GREEN CUTOVER:"
echo "AWS Console -> EC2 -> Load Balancers"
echo "-> lms-blue-green-alb"
echo "-> Listeners -> HTTP :80"
echo "-> Edit default action"
echo "-> Select lms-green-tg"
echo "-> Save"

echo ""
echo "ROLLBACK:"
echo "Change the default target group back to lms-blue-tg"

echo ""
echo "======================================"
