# RideForge X

Premium AI-powered motorcycle ecosystem platform.

## Workspace

```text
RideForge X/
  apps/
    mobile/          Flutter app using Riverpod, GoRouter, Hive
    api/             Node.js + Express API backed by PostgreSQL
  docs/
    ARCHITECTURE.md  System architecture, app layers, data ownership
    API_CONTRACTS.md REST contracts for all core features
```

## Core Features

- Motorcycle Garage
- Service History
- Maintenance Tracking
- Accessory Management
- Touring Planner
- Group Ride Tracking
- AI Diagnostics
- Media Gallery

## Local Setup

Mobile:

```powershell
cd apps/mobile
flutter pub get
flutter run
```

API:

```powershell
cd apps/api
npm install
copy .env.example .env
npm run dev
```

Database:

```powershell
psql $env:DATABASE_URL -f migrations/001_initial_schema.sql
```

