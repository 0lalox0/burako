-- Burako Tracker — Schema
-- Ejecutar una sola vez en Supabase > SQL Editor

create table players (
  id   uuid default gen_random_uuid() primary key,
  name text not null unique,
  created_at timestamp with time zone default now()
);

create table seasons (
  id         uuid default gen_random_uuid() primary key,
  name       text not null,
  started_at timestamp with time zone default now(),
  ended_at   timestamp with time zone,
  is_active  boolean default true
);

create table matches (
  id        uuid default gen_random_uuid() primary key,
  season_id uuid references seasons(id) on delete cascade not null,
  mode      text not null check (mode in ('1v1', '2v2')),
  played_at timestamp with time zone default now()
);

create table match_players (
  id        uuid default gen_random_uuid() primary key,
  match_id  uuid references matches(id) on delete cascade not null,
  player_id uuid references players(id) on delete cascade not null,
  team      smallint not null check (team in (1, 2)),
  is_winner boolean not null
);

-- Acceso público de lectura y escritura (sin auth, proyecto privado por URL)
alter table players      enable row level security;
alter table seasons      enable row level security;
alter table matches      enable row level security;
alter table match_players enable row level security;

create policy "public all" on players       for all using (true) with check (true);
create policy "public all" on seasons       for all using (true) with check (true);
create policy "public all" on matches       for all using (true) with check (true);
create policy "public all" on match_players for all using (true) with check (true);

-- ── Liga formal ──────────────────────────────────────────────────────────────

create table formal_seasons (
  id         uuid default gen_random_uuid() primary key,
  name       text not null,
  is_active  boolean default true,
  created_at timestamp with time zone default now()
);

create table formal_season_players (
  formal_season_id uuid references formal_seasons(id) on delete cascade,
  player_id        uuid references players(id) on delete cascade,
  primary key (formal_season_id, player_id)
);

create table formal_matches (
  id               uuid default gen_random_uuid() primary key,
  formal_season_id uuid references formal_seasons(id) on delete cascade not null,
  team1_p1         uuid references players(id) not null,
  team1_p2         uuid references players(id) not null,
  team2_p1         uuid references players(id) not null,
  team2_p2         uuid references players(id) not null,
  status           text default 'pending' check (status in ('pending', 'complete')),
  winner_team      smallint check (winner_team in (1, 2)),
  played_at        timestamp with time zone,
  created_at       timestamp with time zone default now()
);

alter table formal_seasons        enable row level security;
alter table formal_season_players enable row level security;
alter table formal_matches        enable row level security;

create policy "public all" on formal_seasons        for all using (true) with check (true);
create policy "public all" on formal_season_players for all using (true) with check (true);
create policy "public all" on formal_matches        for all using (true) with check (true);

-- Permisos al rol anon (requerido en proyectos Supabase nuevos)
grant usage on schema public to anon;
grant all on all tables in schema public to anon;
grant all on all sequences in schema public to anon;
