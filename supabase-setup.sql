-- NessaFlow: ein privater Datensatz pro Person
create table if not exists public.nessaflow_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null,
  updated_at bigint not null
);

alter table public.nessaflow_state enable row level security;

create policy "Eigene Daten lesen" on public.nessaflow_state
  for select using (auth.uid() = user_id);
create policy "Eigene Daten anlegen" on public.nessaflow_state
  for insert with check (auth.uid() = user_id);
create policy "Eigene Daten ändern" on public.nessaflow_state
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
