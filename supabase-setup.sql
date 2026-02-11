-- ====================================
-- هاكاثون الوقف - إنشاء الجداول في Supabase
-- قم بنسخ هذا الكود ولصقه في SQL Editor في لوحة تحكم Supabase
-- ====================================

-- 1. جدول المستخدمين
CREATE TABLE IF NOT EXISTS users (
  email TEXT PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  team_name TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT DEFAULT 'فريق مشارك',
  status TEXT DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. جدول المشاريع
CREATE TABLE IF NOT EXISTS projects (
  user_email TEXT PRIMARY KEY REFERENCES users(email) ON DELETE CASCADE,
  leader_name TEXT NOT NULL,
  member2 TEXT,
  member3 TEXT,
  member4 TEXT,
  member5 TEXT,
  challenge TEXT NOT NULL,
  project_idea TEXT NOT NULL,
  file_name TEXT,
  file_url TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. جدول الإعدادات
CREATE TABLE IF NOT EXISTS settings (
  id TEXT PRIMARY KEY DEFAULT 'global',
  registration_open BOOLEAN DEFAULT true,
  registration_date TEXT DEFAULT '2026-03-01T00:00',
  site_name TEXT DEFAULT 'هاكاثون الوقف'
);

-- 4. تعطيل Row Level Security (للتبسيط مع anon key)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- 5. سياسات تسمح بالقراءة والكتابة للجميع (anon key)
CREATE POLICY "Allow all on users" ON users FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on projects" ON projects FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all on settings" ON settings FOR ALL USING (true) WITH CHECK (true);

-- 6. إنشاء Storage Bucket للملفات (اختياري)
-- اذهب إلى Storage في لوحة تحكم Supabase وأنشئ bucket باسم: project-files
-- واجعله Public

-- ====================================
-- انتهى! الآن المنصة جاهزة للعمل مع Supabase
-- ====================================
