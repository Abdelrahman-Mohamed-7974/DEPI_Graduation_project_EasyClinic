-- Chat messages shared between the patient and doctor apps.
create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id text not null,
  sender_role text not null check (sender_role in ('patient', 'doctor')),
  content text not null check (char_length(content) > 0),
  created_at timestamptz not null default now()
);

-- Fast lookup of a conversation's messages in chronological order.
create index if not exists messages_conversation_created_idx
  on public.messages (conversation_id, created_at);

-- Stream inserts to connected clients over Realtime.
alter publication supabase_realtime add table public.messages;

-- Data API access for the anon role (local dev uses the anon key).
grant select, insert on public.messages to anon, authenticated;

-- Row Level Security.
alter table public.messages enable row level security;

-- DEV-ONLY policies: there is no auth yet, so the anon key may read and write
-- any message in the demo conversation. Tighten these to per-user / per-
-- conversation ownership once authentication is implemented.
create policy "dev anon can read messages"
  on public.messages
  for select
  to anon, authenticated
  using (true);

create policy "dev anon can send messages"
  on public.messages
  for insert
  to anon, authenticated
  with check (true);
