// ==========================================
// Qarzhy.kz — Барлық баптаулар осы файлда
// ==========================================

const CONFIG = {
  // 1. Supabase — тегін: supabase.com → жаңа жоба → Settings → API
  // ЕСКЕРТУ: тек "anon public" кілтін қой — ол клиент жақта ашық болуға арналған.
  // Кестелерге RLS (Row Level Security) қосылмаса, деректер қорғалмайды!
  SUPABASE_URL: 'https://wwwcskgeziqlelgtoaxw.supabase.co',
  SUPABASE_KEY: 'sb_publishable_yTHCrpbWJk7RoTcAje17yg_B4L5_V2c',

  // 2. NewsAPI — тегін: newsapi.org → тіркел → API key
  // ЕСКЕРТУ: NewsAPI тегін жоспары браузерден (production доменнен) тікелей
  // сұрау салуға тыйым салады — тек localhost-та жұмыс істейді. Production-да
  // қолдану үшін кілтті сервер жақтағы proxy (мыс. Supabase Edge Function)
  // арқылы жасыру керек, оны осы файлға ешқашан қоймаңыз.
  NEWS_API_KEY: 'СІЗДІҢ_NEWS_API_KEY',

  // Claude API кілтін бұл файлға ЕШҚАШАН қоймаңыз — бұл файл браузерде толық
  // ашық түрде жүктеледі, кез келген адам "View Source"-пен көре алады.
  // AI мүмкіндігі керек болса, кілтті Supabase Edge Function/серверлік
  // функцияда сақтап, сайт соған сұрау салсын.

  // Жаңалық санаттары
  NEWS_CATEGORIES: [
    { id: 'all',      label: 'Барлығы',    query: 'Kazakhstan finance economy investment 2025' },
    { id: 'economy',  label: 'Экономика',  query: 'Kazakhstan economy GDP inflation central bank' },
    { id: 'stocks',   label: 'Акциялар',   query: 'KASE Kazakhstan stock market shares' },
    { id: 'crypto',   label: 'Крипто',     query: 'Bitcoin Ethereum cryptocurrency market 2025' },
    { id: 'currency', label: 'Валюта',     query: 'Kazakhstan tenge USD KZT exchange rate' },
    { id: 'invest',   label: 'Инвестиция', query: 'investment fund ETF portfolio Kazakhstan' },
  ],

  // Нарық деректері (болашақта API-мен алмастыру)
  MARKET_REFRESH_MS: 60000, // 1 минут
};
