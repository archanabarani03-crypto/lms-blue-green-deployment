# LMS Blue-Green Deployment - Architecture

## 1. Architecture Overview

The Blue-Green deployment architecture maintains two separate LMS environments:

- Blue - Existing stable production environment
- Green - New LMS version

An AWS Application Load Balancer (ALB) is used as the single traffic entry point.

Only one environment receives active production traffic at a time.

The inactive environment remains available for validation and rollback.

---

## 2. High-Level Architecture

```text
                         Students / Users
                                |
                                |
                                v
                    +-----------------------+
                    |  AWS Application      |
                    |  Load Balancer        |
                    |  lms-blue-green-alb   |
                    +-----------+-----------+
                                |
                                |
                    +-----------+-----------+
                    |                       |
                    v                       v
             +-------------+         +-------------+
             | lms-blue-tg |         | lms-green-tg|
             +------+------+         +------+------+
                    |                       |
                    v                       v
             +-------------+         +-------------+
             |  Blue EC2   |         |  Green EC2  |
             |172.31.47.197|         |172.31.43.211|
             +------+------+         +------+------+
                    |                       |
                    v                       v
             +-------------+         +-------------+
             | Open edX +  |         | Open edX +  |
             |    Tutor    |         |    Tutor    |
             +-------------+         +-------------+
