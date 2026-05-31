# RideForge X API Contracts

Base URL: `/api/v1`

Authentication: `Authorization: Bearer <token>`

Common error response:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human readable message",
    "details": {}
  }
}
```

## Motorcycle Garage

### `GET /motorcycles`

Returns all motorcycles owned by the authenticated user.

### `POST /motorcycles`

```json
{
  "nickname": "Night Fury",
  "make": "Triumph",
  "model": "Street Triple RS",
  "year": 2025,
  "vin": "SMTT...",
  "odometerKm": 8200,
  "purchaseDate": "2025-10-02",
  "imageUrl": "https://..."
}
```

### `PATCH /motorcycles/{id}`

Partial update of motorcycle profile.

### `DELETE /motorcycles/{id}`

Soft deletes a motorcycle and keeps historical records.

## Service History

### `GET /motorcycles/{motorcycleId}/service-records`

Returns service records ordered by service date descending.

### `POST /motorcycles/{motorcycleId}/service-records`

```json
{
  "serviceDate": "2026-05-12",
  "odometerKm": 9200,
  "provider": "Authorized Service Center",
  "summary": "Oil, filters, brake inspection",
  "cost": 18450,
  "currency": "INR",
  "invoiceMediaId": "media_123"
}
```

## Maintenance Tracking

### `GET /motorcycles/{motorcycleId}/maintenance-tasks`

Returns open and completed maintenance tasks.

### `POST /motorcycles/{motorcycleId}/maintenance-tasks`

```json
{
  "title": "Chain cleaning",
  "category": "drivetrain",
  "dueDate": "2026-06-15",
  "dueOdometerKm": 10000,
  "priority": "medium",
  "status": "open"
}
```

### `PATCH /motorcycles/{motorcycleId}/maintenance-tasks/{id}/complete`

```json
{
  "completedAt": "2026-05-31T12:00:00Z",
  "odometerKm": 9800,
  "notes": "Cleaned and lubed"
}
```

## Accessory Management

### `GET /motorcycles/{motorcycleId}/accessories`

Returns installed and planned accessories.

### `POST /motorcycles/{motorcycleId}/accessories`

```json
{
  "name": "Crash guards",
  "brand": "SW-Motech",
  "category": "protection",
  "installedOn": "2026-04-20",
  "cost": 26500,
  "currency": "INR",
  "warrantyUntil": "2028-04-20",
  "notes": "Installed before Ladakh prep"
}
```

## Touring Planner

### `GET /tour-plans`

Returns user tour plans.

### `POST /tour-plans`

```json
{
  "name": "Western Ghats Monsoon Loop",
  "motorcycleId": "moto_123",
  "startDate": "2026-07-10",
  "endDate": "2026-07-14",
  "waypoints": [
    { "label": "Bengaluru", "lat": 12.9716, "lng": 77.5946 },
    { "label": "Chikmagalur", "lat": 13.3161, "lng": 75.7720 }
  ],
  "preferences": {
    "avoidHighways": false,
    "scenicBias": 0.8
  }
}
```

### `POST /tour-plans/{id}/optimize-route`

Uses Mapbox to enrich route geometry, distance, ETA, and fuel stops.

## Group Ride Tracking

### `POST /group-rides`

```json
{
  "name": "Sunday Breakfast Ride",
  "tourPlanId": "tour_123",
  "startsAt": "2026-06-07T01:30:00Z",
  "visibility": "invite_only"
}
```

### `POST /group-rides/{id}/join`

```json
{
  "inviteCode": "RF-X7K2"
}
```

### `POST /group-rides/{id}/locations`

```json
{
  "lat": 12.9352,
  "lng": 77.6245,
  "speedKph": 54.2,
  "heading": 124,
  "recordedAt": "2026-05-31T12:00:00Z"
}
```

### `GET /group-rides/{id}/locations/live`

Returns latest member locations.

## AI Diagnostics

### `POST /diagnostics/analyze`

```json
{
  "motorcycleId": "moto_123",
  "symptoms": ["Hard cold start", "Uneven idle"],
  "obdCodes": ["P0171"],
  "audioMediaId": "media_456"
}
```

Response:

```json
{
  "id": "diag_123",
  "severity": "medium",
  "confidence": 0.82,
  "likelyCauses": ["Lean air-fuel mixture", "Vacuum leak"],
  "recommendedActions": ["Inspect intake boots", "Check fuel pressure"],
  "safeToRide": true
}
```

## Media Gallery

### `POST /media/upload-intent`

```json
{
  "ownerType": "motorcycle",
  "ownerId": "moto_123",
  "fileName": "invoice.pdf",
  "contentType": "application/pdf"
}
```

Response:

```json
{
  "mediaId": "media_123",
  "uploadUrl": "https://firebase-upload-url",
  "storagePath": "users/user_123/motorcycles/moto_123/invoice.pdf"
}
```

### `GET /media?ownerType=motorcycle&ownerId=moto_123`

Returns gallery items for an owner.
