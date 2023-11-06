/*
61. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
62. Kaç ülkeden müşterim var
63. Hangi ülkeden kaç müşterimiz var
64. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
69. Brezilya’da olmayan müşteriler
70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
71. Faks numarasını bilmediğim müşteriler
72. Londra’da ya da Paris’de bulunan müşterilerim
73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
74. C ile başlayan ürünlerimin isimleri ve fiyatları
75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
79. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
80. Faks numarasını bilmediğim müşteriler
81. Müşterilerimi ülkeye göre sıralıyorum:
82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
84. 1 Numaralı kategoride kaç ürün vardır..?
85. Kaç farklı ülkeye ihracat yapıyorum..?
*/

-- 61
select products.product_name, categories.category_name,
suppliers.company_name, order_details.quantity from public.products
inner join public.categories on products.category_id = categories.category_id
inner join public.suppliers on products.supplier_id = suppliers.supplier_id
inner join public.order_details on order_details.product_id = products.product_id
order by order_details.quantity desc limit 1;


-- 62
select count(distinct country) from customers;


-- 63
select count(customer_id), country from customers
group by country
order by count;


-- 64
select sum(order_details.quantity * order_details.unit_price) from orders
inner join employees on orders.employee_id = employees.employee_id
inner join order_details on order_details.order_id = orders.order_id
where employees.employee_id = 3 and orders.order_date >= '1998-01-01';


-- 65
select od.product_id, sum(od.quantity * od.unit_price)
from order_details od
join orders o on od.order_id = o.order_id
where od.product_id = 10 and o.order_date >= date '1998-05-31' - interval '3 months'
group by od.product_id;


-- 66
select sum(order_details.quantity), orders.employee_id,
employees.first_name, employees.last_name from orders
inner join employees on orders.employee_id = employees.employee_id
inner join order_details on orders.order_id = order_details.order_id
group by orders.employee_id, employees.first_name, employees.last_name;


-- 67. Selects identify the two customers out of 91 who have not placed any orders
select company_name, order_id from orders 
right join customers on customers.customer_id = orders.customer_id
where orders.order_id is null
order by company_name;


-- 68
select company_name, contact_name, address, city, country from customers
where country = 'Brazil' order by company_name;


-- 69
select company_name, contact_name, address, city, country
from customers where country != 'brazil' order by company_name;


-- 70
select company_name, country from customers
where country = 'Spain' or country = 'France' or country = 'Germany'
order by country;


-- 71
select company_name, fax from customers
where fax is null order by company_name;


-- 72
select company_name, contact_name, address, city, country from customers
where city = 'London' or city= 'Paris' order by city;


-- 73
select company_name, contact_name, address, city, country from customers
where city = 'México D.F.' and contact_title = 'Owner';


-- 74
select product_name, unit_price from products
where lower(product_name) like 'c%';


-- 75
select  first_name, last_name, birth_date from employees
where lower(first_name) like 'a%';


-- 76
select company_name from customers
where lower(company_name) like '%restaurant%';


-- 77
select product_name, unit_price from products
where unit_price between 50 and 100
order by unit_price;


-- 78
select order_id, order_date from orders
where order_date between '1996-07-01' and '1996-12-31';


-- 79
select country, company_name from customers
where country = 'Spain' or country = 'France' or country = 'Germany'
order by country;


-- 80
select company_name, fax from customers
where fax is null
order by company_name;


-- 81
select distinct country, company_name from customers
order by country;


-- 82
select product_name, unit_price from products
order by unit_price desc;


-- 83
select product_name, unit_price, units_in_stock from products
order by unit_price desc, units_in_stock asc;


-- 84
select count(*) product_count, category_id
from products
where category_id = 1
group by category_id;


-- 85
select count(distinct country)
from customers;
