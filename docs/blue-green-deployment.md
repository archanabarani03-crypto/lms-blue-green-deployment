# LMS Blue-Green Deployment - Detailed Implementation

## 1. Objective

Implement a Blue-Green deployment strategy for an Open edX LMS running on AWS EC2 using Tutor.

The objective is to deploy a new LMS version in a separate Green environment, validate it without affecting the existing Blue environment, switch production traffic through an AWS Application Load Balancer, and provide a quick rollback mechanism.

---

# 2. Problem Statement

A new LMS version needs to be released without interrupting students currently using the application.

Stopping or directly upgrading the production LMS can result in:

- Application downtime
- Interrupted student sessions
- Failed requests
- Deployment risk
- Difficult rollback

The Blue-Green strategy solves this by maintaining two environments:

- Blue - current stable production environment
- Green - new version being prepared

Production traffic is controlled using an AWS Application Load Balancer.

---

# 3. Architecture

```text
                         Internet
                            |
                            v
                +-----------------------+
                | AWS Application       |
                | Load Balancer         |
                | lms-blue-green-alb    |
                +-----------+-----------+
                            |
                     Active Target
                            |
                            v
                +-----------------------+
                | lms-green-tg          |
                +-----------+-----------+
                            |
                            v
                +-----------------------+
                | Green EC2             |
                | 172.31.43.211         |
                | Open edX + Tutor      |
                +-----------------------+

                       Rollback
                           |
                           v
                +-----------------------+
                | lms-blue-tg           |
                +-----------+-----------+
                            |
                            v
                +-----------------------+
                | Blue EC2              |
                | 172.31.47.197         |
                | Open edX + Tutor      |
                +-----------------------+
