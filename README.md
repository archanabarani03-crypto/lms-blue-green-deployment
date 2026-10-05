# LMS Blue-Green Deployment

## 1. Project Overview

This project demonstrates a Blue-Green deployment strategy for an Open edX LMS deployed using Tutor on AWS EC2.

The objective is to release a new LMS version without interrupting students currently using the application.

The deployment uses:

- AWS EC2
- Docker
- Tutor
- Open edX LMS
- AWS Application Load Balancer
- Blue Target Group
- Green Target Group
- GitHub
- AWS IAM
- HTTP health checks

---

## 2. Problem Statement

A new LMS version needs to be released without interrupting students currently using the application.

A traditional deployment would update the existing production server directly. This can cause:

- Application downtime
- Failed deployments
- Service interruption
- Difficult rollback
- Impact to active users

To avoid this, a Blue-Green deployment strategy is implemented.

The existing stable environment is called **Blue** and the new environment is called **Green**.

The new version is deployed and validated in Green before production traffic is switched from Blue to Green.

---

## 3. Blue-Green Architecture

```text
                         Internet
                            |
                            v
                +-----------------------+
                |   Application Load    |
                |       Balancer        |
                |   lms-blue-green-alb  |
                +-----------+-----------+
                            |
                HTTP :80 Listener
                            |
                 +----------+----------+
                 |                     |
                 v                     v
        +----------------+    +----------------+
        | lms-blue-tg    |    | lms-green-tg   |
        | Target Group   |    | Target Group   |
        +-------+--------+    +-------+--------+
                |                     |
                v                     v
        +----------------+    +----------------+
        | Blue EC2       |    | Green EC2      |
        | Open edX       |    | Open edX       |
        | Tutor          |    | Tutor          |
        | Docker         |    | Docker         |
        +----------------+    +----------------+
                |                     |
                v                     v
             Stable              New Release
