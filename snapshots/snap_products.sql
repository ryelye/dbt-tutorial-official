/*

uncomment ( {##} ) to use later

{# {% snapshot snap_products %} #}

 {{
     config(
         target_database='dbt',
         target_schema='product_snapshots',
         unique_key='id',

         strategy='timestamp', 
         updated_at='updated_at'
         
     )
 }}
--timestamp or check (timestamp better)
--check_cols=['price'] -- used with CHECK (no reliable timestamp, or we only care about checks in certain columns)
--select id, price from {{ source('jaffle_shop_ext', 'products')}}

{# {% endsnapshot %} #}

*/