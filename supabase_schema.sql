-- Qarzhy.kz — Supabase кестелері
-- Supabase → SQL Editor → осыны paste → Run

-- 1. Пайдаланушылар профилі
create table profiles (
  id uuid references auth.users primary key,
  username text unique not null,
  full_name text,
  bio text,
  avatar_url text,
  role text default 'user',
  reputation int default 0,
  created_at timestamptz default now()
);

-- 2. Форум сұрақтары
create table forum_posts (
  id bigserial primary key,
  user_id uuid references profiles(id),
  title text not null,
  content text not null,
  category text not null, -- stocks | crypto | currency | economy | invest
  views int default 0,
  is_solved boolean default false,
  created_at timestamptz default now()
);

-- 3. Форум жауаптары
create table forum_answers (
  id bigserial primary key,
  post_id bigint references forum_posts(id) on delete cascade,
  user_id uuid references profiles(id),
  content text not null,
  is_accepted boolean default false,
  votes int default 0,
  created_at timestamptz default now()
);

-- 4. Инвестициялық идеялар
create table investment_ideas (
  id bigserial primary key,
  user_id uuid references profiles(id),
  asset_name text not null,        -- KMG, BTC, HSBK...
  asset_symbol text not null,
  direction text not null,         -- long | short
  target_price text not null,
  potential_pct text not null,     -- +18%, -10%
  risk_level text not null,        -- low | medium | high
  description text,
  category text not null,          -- stocks | crypto | currency | commodity
  is_active boolean default true,
  created_at timestamptz default now()
);

-- 5. Курстар
create table courses (
  id bigserial primary key,
  title text not null,
  description text,
  category text not null,          -- basics | crypto | technical | fundamental
  level text not null,             -- beginner | intermediate | advanced
  thumbnail_emoji text default '📊',
  is_free boolean default true,
  lessons_count int default 0,
  rating numeric(3,1) default 5.0,
  reviews_count int default 0,
  created_at timestamptz default now()
);

-- 6. Сабақтар
create table lessons (
  id bigserial primary key,
  course_id bigint references courses(id) on delete cascade,
  title text not null,
  content text,
  video_url text,
  pdf_url text,
  duration_min int,
  order_num int not null,
  created_at timestamptz default now()
);

-- 7. Портфолио
create table portfolios (
  id bigserial primary key,
  user_id uuid references profiles(id),
  asset_name text not null,
  asset_symbol text not null,
  asset_type text not null,        -- stock | crypto | bond | cash
  amount numeric not null,
  buy_price numeric not null,
  currency text default 'KZT',
  created_at timestamptz default now()
);

-- 8. Сақталған жаңалықтар
create table bookmarks (
  id bigserial primary key,
  user_id uuid references profiles(id),
  article_url text not null,
  article_title text not null,
  article_category text,
  created_at timestamptz default now(),
  unique(user_id, article_url)
);

-- 9. Экономикалық күнтізбе оқиғалары
create table calendar_events (
  id bigserial primary key,
  title text not null,
  event_date timestamptz not null,
  impact text not null,            -- high | medium | low
  description text,
  country text default 'KZ',
  created_at timestamptz default now()
);

-- Row Level Security
alter table profiles enable row level security;
alter table forum_posts enable row level security;
alter table forum_answers enable row level security;
alter table portfolios enable row level security;
alter table bookmarks enable row level security;
alter table investment_ideas enable row level security;
alter table courses enable row level security;
alter table lessons enable row level security;
alter table calendar_events enable row level security;

-- Кез келген адам оқи алады
create policy "Public read posts" on forum_posts for select using (true);
create policy "Public read answers" on forum_answers for select using (true);
create policy "Public read ideas" on investment_ideas for select using (true);
create policy "Public read courses" on courses for select using (true);
create policy "Public read lessons" on lessons for select using (true);
create policy "Public read calendar" on calendar_events for select using (true);

-- Тіркелген адам жаза алады
create policy "Auth write posts" on forum_posts for insert with check (auth.uid() = user_id);
create policy "Auth write answers" on forum_answers for insert with check (auth.uid() = user_id);
create policy "Auth write ideas" on investment_ideas for insert with check (auth.uid() = user_id);
create policy "Auth portfolio" on portfolios for all using (auth.uid() = user_id);
create policy "Auth bookmarks" on bookmarks for all using (auth.uid() = user_id);
create policy "Own profile" on profiles for all using (auth.uid() = id);

-- Бастапқы деректер: экономикалық күнтізбе
insert into calendar_events (title, event_date, impact, country) values
  ('АҚШ инфляция деректері (CPI)', now() + interval '1 day', 'high', 'US'),
  ('ҚР ЖІӨ өсу қарқыны', now() + interval '2 days', 'medium', 'KZ'),
  ('Fed мөлшерлеме шешімі', now() + interval '4 days', 'high', 'US'),
  ('KMG тоқсандық есебі', now() + interval '7 days', 'low', 'KZ');

-- Бастапқы деректер: курстар
insert into courses (title, description, category, level, thumbnail_emoji, is_free, lessons_count, rating, reviews_count) values
  ('Инвестицияның негіздері — нөлден бастап', 'Инвестиция дегеніміз не, қайдан бастау керек, тәуекелді қалай басқару керек', 'basics', 'beginner', '📊', true, 32, 4.9, 412),
  ('Криптовалютаға инвестиция — тәуекел мен мүмкіндік', 'Bitcoin, Ethereum, DeFi, NFT — барлығын қазақша', 'crypto', 'intermediate', '₿', true, 24, 4.7, 256),
  ('Техникалық талдау — графиктерді оқу өнері', 'Свечалар, индикаторлар, тренд сызықтары, паттерндер', 'technical', 'advanced', '📈', false, 40, 4.8, 198),
  ('KASE нарығына инвестиция — қазақстандық акциялар', 'KMG, Halyk Bank, Kaspi, Kcell акцияларын талдау', 'basics', 'intermediate', '🏦', true, 28, 4.8, 143),
  ('Портфолио құру — диверсификация принциптері', 'Тәуекелді бөлу, актив класстары, ребалансировка', 'fundamental', 'intermediate', '💼', true, 20, 4.9, 89),
  ('Фундаментальды талдау — компанияларды бағалау', 'P/E, EPS, EBITDA, DCF — компанияның шынайы бағасын тап', 'fundamental', 'advanced', '🔍', false, 35, 4.7, 67);

-- Бастапқы деректер: инвестициялық идеялар
insert into investment_ideas (user_id, asset_name, asset_symbol, direction, target_price, potential_pct, risk_level, description, category) 
select id, 'KazMunayGas', 'KMG', 'long', '4 200 ₸', '+18%', 'medium', 'Мұнай бағасының тұрақтануы және дивиденд өсімі.', 'stocks'
from profiles limit 1;
