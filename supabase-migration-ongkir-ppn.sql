-- PT Medical Prima Utama
-- Tambahan biaya ongkir dan persentase PPN untuk rincian item proyek.
-- Aman dijalankan berulang kali.
alter table public.project_items
  add column if not exists shipping_cost numeric(18,2) not null default 0,
  add column if not exists ppn_percent numeric(5,2) not null default 0;

alter table public.project_items
  drop constraint if exists project_items_shipping_cost_check,
  add constraint project_items_shipping_cost_check
    check (shipping_cost >= 0),
  drop constraint if exists project_items_ppn_percent_check,
  add constraint project_items_ppn_percent_check
    check (ppn_percent >= 0 and ppn_percent <= 100);
