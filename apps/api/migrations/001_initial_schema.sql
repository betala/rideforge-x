create extension if not exists "uuid-ossp";

create table if not exists motorcycles (
  id uuid primary key,
  user_id text not null,
  nickname text not null,
  make text not null,
  model text not null,
  year integer not null,
  vin text,
  odometer_km integer not null default 0,
  purchase_date date,
  image_url text,
  deleted_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists service_records (
  id uuid primary key,
  motorcycle_id uuid not null references motorcycles(id),
  service_date date not null,
  odometer_km integer not null,
  provider text,
  summary text not null,
  cost numeric(12,2),
  currency text,
  invoice_media_id uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists maintenance_tasks (
  id uuid primary key,
  motorcycle_id uuid not null references motorcycles(id),
  title text not null,
  category text not null,
  due_date date,
  due_odometer_km integer,
  priority text not null default 'medium',
  status text not null default 'open',
  completed_at timestamptz,
  completed_odometer_km integer,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists accessories (
  id uuid primary key,
  motorcycle_id uuid not null references motorcycles(id),
  name text not null,
  brand text,
  category text not null,
  installed_on date,
  cost numeric(12,2),
  currency text,
  warranty_until date,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists tour_plans (
  id uuid primary key,
  user_id text not null,
  motorcycle_id uuid references motorcycles(id),
  name text not null,
  start_date date,
  end_date date,
  waypoints jsonb not null default '[]'::jsonb,
  preferences jsonb not null default '{}'::jsonb,
  route_geometry text,
  distance_km numeric(10,2),
  eta_minutes integer,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists group_rides (
  id uuid primary key,
  owner_user_id text not null,
  tour_plan_id uuid references tour_plans(id),
  name text not null,
  starts_at timestamptz not null,
  visibility text not null default 'invite_only',
  invite_code text not null unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists group_ride_members (
  group_ride_id uuid not null references group_rides(id),
  user_id text not null,
  joined_at timestamptz not null default now(),
  primary key (group_ride_id, user_id)
);

create table if not exists group_ride_locations (
  id uuid primary key,
  group_ride_id uuid not null references group_rides(id),
  user_id text not null,
  lat numeric(10,7) not null,
  lng numeric(10,7) not null,
  speed_kph numeric(7,2),
  heading numeric(6,2),
  recorded_at timestamptz not null
);

create table if not exists diagnostic_reports (
  id uuid primary key,
  user_id text not null,
  motorcycle_id uuid not null references motorcycles(id),
  symptoms jsonb not null default '[]'::jsonb,
  obd_codes jsonb not null default '[]'::jsonb,
  severity text not null,
  confidence numeric(4,3) not null,
  likely_causes jsonb not null default '[]'::jsonb,
  recommended_actions jsonb not null default '[]'::jsonb,
  safe_to_ride boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists media_items (
  id uuid primary key,
  user_id text not null,
  owner_type text not null,
  owner_id text not null,
  storage_path text not null,
  content_type text not null,
  url text,
  caption text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_motorcycles_user_id on motorcycles(user_id);
create index if not exists idx_service_records_motorcycle_id on service_records(motorcycle_id);
create index if not exists idx_maintenance_tasks_motorcycle_id on maintenance_tasks(motorcycle_id);
create index if not exists idx_accessories_motorcycle_id on accessories(motorcycle_id);
create index if not exists idx_tour_plans_user_id on tour_plans(user_id);
create index if not exists idx_group_ride_locations_live on group_ride_locations(group_ride_id, user_id, recorded_at desc);
create index if not exists idx_media_items_owner on media_items(user_id, owner_type, owner_id);
