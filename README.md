# LMS Blue-Green Deployment

## Project Overview

This project implements a Blue-Green deployment strategy for an LMS application.

## Deployment Environments

- Blue: Current production LMS version
- Green: New LMS version

## Deployment Flow

GitHub
↓
Deploy New Version to Green
↓
Health Check
↓
Functional Testing
↓
Switch ALB Traffic
↓
Green becomes Production

## Rollback

If the Green environment fails, traffic is switched back to Blue.

## Technologies

- AWS EC2
- Docker
- Tutor
- Open edX LMS
- AWS Application Load Balancer
- GitHub
