-- In-app notifications for the patient and doctor apps.
create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  recipient_role text not null check (recipient_role in ('patient', 'doctor')),
  title text not null,
  body text not null,
  type text not null default 'message',
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create index if not exists notifications_recipient_created_idx
  on public.notifications (recipient_role, created_at desc);

-- Stream changes to connected clients over Realtime.
alter publication supabase_realtime add table public.notifications;

-- Data API access for the anon role (local dev uses the anon key).
grant select, insert, update on public.notifications to anon, authenticated;

alter table public.notifications enable row level security;

-- DEV-ONLY policies (no auth yet). Tighten to per-user ownership once
-- authentication is implemented.
create policy "dev anon can read notifications"
  on public.notifications
  for select
  to anon, authenticated
  using (true);

create policy "dev anon can insert notifications"
  on public.notifications
  for insert
  to anon, authenticated
  with check (true);

create policy "dev anon can update notifications"
  on public.notifications
  for update
  to anon, authenticated
  using (true)
  with check (true);

-- Auto-notify the other party when a chat message is inserted.
-- SECURITY INVOKER: runs as the inserting role (anon), which has the grants
-- and RLS policies above; no privilege escalation.
create or replace function public.notify_message_recipient()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  insert into public.notifications (recipient_role, title, body, type)
  values (
    case new.sender_role when 'patient' then 'doctor' else 'patient' end,
    case new.sender_role
      when 'patient' then 'New message from your patient'
      else 'New message from Dr. Olivia Turner'
    end,
    left(new.content, 120),
    'message'
  );
  return new;
end;
$$;

create trigger messages_notify_recipient
  after insert on public.messages
  for each row
  execute function public.notify_message_recipient();
