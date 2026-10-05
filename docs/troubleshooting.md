# LMS Blue-Green Deployment - Troubleshooting

## 1. Purpose

This document describes the troubleshooting performed during the LMS Blue-Green deployment.

The main areas validated were:

- Green Tutor services
- Open edX application response
- Caddy
- HTTP connectivity
- ALB
- Target groups
- Blue-Green traffic switching
- Rollback

---

# 2. Green LMS Service Check

Check Tutor services:

```bash
source ~/tutor-venv/bin/activate
tutor local status
