# Relo

Relo is a relocation planning workspace built with Ruby on Rails.

This project focuses on helping users plan a move end-to-end: compare neighborhoods, track listings, manage viewings and applications, organize tasks and deadlines, and collaborate in a shared workspace.

## Why This Project Exists

The goal is to demonstrate:
- strong Rails full-stack engineering
- product thinking (not just CRUD)
- realistic domain modeling and workflows
- role-based authorization and subscription gating
- integration experience (billing, geocoding, imports)
- background jobs and async workflows
- polished, maintainable code quality

## Product Positioning

Relo is a relocation workspace:
- manual-first
- integration-enhanced
- fully usable without third-party APIs
- rich seed/demo scenarios, but also usable from an empty account

## Current Status

This repository is in active build phase.

Implemented foundation:
- Rails 8.1 app skeleton
- PostgreSQL setup
- RSpec + RuboCop toolchain
- baseline gems for auth, policies, background processing, billing, search, and geocoding

Planned core modules:
- workspaces + memberships + roles (`owner`, `editor`, `viewer`, `guest`)
- relocation plans, neighborhoods, listings, viewings, applications
- task timeline and deadline tracking
- document vault and activity feed
- subscription tiers (`Free`, `Premium`, `Shared`)

## Target User Flows

1. Create workspace and relocation plan
2. Compare neighborhoods by custom criteria
3. Save/import listing candidates
4. Track listing state (`saved`, `touring`, `applied`, `shortlisted`, `rejected`, `leased`)
5. Add notes, scoring, costs, and red flags
6. Manage move tasks and deadlines
7. Collaborate with partner/family in shared workspace

## Tech Stack

- Ruby 3.3.x
- Rails 8.1
- PostgreSQL
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Devise
- Pundit
- Sidekiq + Redis
- Stripe
- Active Storage
- PgSearch
- Geocoder
- RSpec + FactoryBot + Faker
- RuboCop (+ Rails/RSpec/Performance)

## Local Setup

### 1. Prerequisites

- Ruby 3.3.x
- PostgreSQL
- Redis
- Bundler

### 2. Install dependencies

```bash
bundle install
```

### 3. Prepare database

```bash
bin/rails db:prepare
```

### 4. Run app

Default app port is `3001`.

```bash
bin/rails s
```

Alternative (Foreman + Procfile):

```bash
bin/dev
```

### 5. Run tests

```bash
bin/rspec spec
```

## Code Quality

Run lint:

```bash
bin/rubocop
```

Run security checks:

```bash
bin/brakeman
bin/bundler-audit
```

## Deployment Direction

- Containerized deployment with Kamal
- Production infra expected to use managed Postgres + Redis
- Background jobs via Sidekiq

## Non-Goals

- generic todo/blog/shop tutorial app
- backend-only API demo
- overengineered SPA or microservices architecture
