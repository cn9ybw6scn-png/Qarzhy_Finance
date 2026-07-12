// ==========================================
// Qarzhy.kz — Барлық баптаулар осы файлда
// ==========================================

const CONFIG = {
  // 1. Supabase — тегін: supabase.com → жаңа жоба → Settings → API
  SUPABASE_URL: 'https://СІЗДІҢ_ID.supabase.co',
  SUPABASE_KEY: 'СІЗДІҢ_ANON_KEY',

  // 2. NewsAPI — тегін: newsapi.org → тіркел → API key
  NEWS_API_KEY: 'СІЗДІҢ_NEWS_API_KEY',

  // 3. Claude API — тегін $5 кредит: console.anthropic.com
  CLAUDE_API_KEY: 'СІЗДІҢ_CLAUDE_KEY',

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
