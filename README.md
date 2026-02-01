# Issue / Product Feedback Management API

A backend-focused Rails API for managing issues, comments, and issue lifecycles.

## Tech Stack

- Ruby on Rails (API-only)
- SQLite
- JWT Authentication
- ActiveRecord

## Features

- User authentication (JWT)
- Create and manage issues
- Issue lifecycle (open → in_progress → resolved)
- Priority-based issues
- Commenting system
- Filtering & pagination
- Basic analytics

## API Endpoints

### Auth

- POST /signup
- POST /login

### Issues

- POST /issues
- GET /issues
- PATCH /issues/:id
- GET /issues/analytics

### Comments

- POST /issues/:issue_id/comments
