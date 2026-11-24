-- PT Medical Prima Utama
-- PPN dan ongkir berlaku satu kali untuk keseluruhan proyek, bukan per item.
-- Aman dijalankan berulang kali.
alter table public.projects
  add column if not exists shipping_cost numeric(18,2) not null default 0,
  add column if not exists ppn_percent numeric(5,2) not null default 0;

alter table public.projects
  drop constraint if exists projects_shipping_cost_check,
  add constraint projects_shipping_cost_check
    check (shipping_cost >= 0),
  drop constraint if exists projects_ppn_percent_check,
  add constraint projects_ppn_percent_check
    check (ppn_percent >= 0 and ppn_percent <= 100);

-- Kolom project_items.shipping_cost dan project_items.ppn_percent dari
-- migrasi versi sebelumnya dibiarkan utuh demi keamanan data, tetapi
-- tidak lagi digunakan oleh aplikasi.
