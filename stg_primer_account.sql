
with source as ( SELECT * FROM {{ ref("primer_account")}}),

    cleaned as 
    (
            select 
            primer_account_id as merchant_id , 
            trim(company_name) as company_name , 
            created_at as created_at_date

            from source

    )

select * from cleaned
