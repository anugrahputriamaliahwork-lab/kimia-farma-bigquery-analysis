--Syntax Querying data dari 4 tabel menjadi satu tabel
SELECT
  ft.transaction_id,
  ft.date AS transaction_date, -- mengubah nama kolom dari "date" ke "transaction_date"
  kc.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang, -- mengubah nama kolom dari "rating" ke "rating_cabang"
  ft.customer_name,
  pd.product_id,
  pd.product_name,
  ft.price AS actual_price, -- mengubah nama kolom dari "price" ke "actual_price"
  ft.discount_percentage,
  CASE 
      WHEN ft.price > 500000 THEN 0.30
      WHEN ft.price > 300000 THEN 0.25
      WHEN ft.price > 100000 THEN 0.20
      WHEN ft.price > 50000  THEN 0.15
      ELSE 0.10
    END AS presentase_gros_laba, 
  ft.price - (ft.price * ft.discount_percentage) AS nett_sales, -- menghitung nett sales = harga -(harga*diskon)
  ROUND(
  (ft.price - (ft.price * ft.discount_percentage)) *
  CASE
    WHEN ft.price > 500000 THEN 0.30
    WHEN ft.price > 300000 THEN 0.25
    WHEN ft.price > 100000 THEN 0.20
    WHEN ft.price > 50000 THEN 0.15
    ELSE 0.10
  END, 
2) AS nett_profit, -- menghitung nett profit = nett sales * presentase gros laba
  ft.rating AS rating_transaksi -- mengubah nama kolom dari "rating" ke "rating_transaksi"
FROM kimia_farma.kf_final_transaction ft
--ini adalah proses join dari tabel kf_final_transaction ke kf_product dan kf_kantor_cabang
JOIN kimia_farma.kf_product pd 
  ON ft.product_id = pd.product_id
JOIN kimia_farma.kf_kantor_cabang kc 
  ON ft.branch_id = kc.branch_id;
