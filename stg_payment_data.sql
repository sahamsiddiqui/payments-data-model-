
with source as ( SELECT * FROM {{ ref("payment_data")}}),

processed as (

    SELECT 
    -- Handle ID columns (convert to STRING for consistency)
        CAST(payment_id AS STRING) AS payment_id,
        CAST(currency_code AS STRING)  as currency_code,
        CAST(token_id AS STRING) AS token_id,
        CAST(vaulted_token_id AS STRING) AS vaulted_token_id,
        CAST(merchant_payment_id AS STRING) AS merchant_payment_id,
        CAST(primer_account_id AS STRING) AS primer_account_id,
    -- Statement descriptor: Handle NULLs and rename for clarity
        COALESCE(statement_descriptor, 'UNKNOWN') AS statement_descriptor,
        TRIM(processor_merchant_id) AS processor_merchant_id,
        TRIM(processor) AS processor,
        status AS status,
        -- STATUS_CATEGORY 
        CASE  WHEN status in ('CANCELLED' , 'SETTLED', 'AUTHORIZED' ,  'SETTLING', 'PARTIALLY_SETTLED') THEN 'SUCCESSFYLLY_AUTHORIZED'
                WHEN status in ('FAILED','DECLINED') THEN 'NOT_AUTHORIZED'
                ELSE  'PENDING'
        END AS status_category,
        created_at,
        updated_at,
        CAST(created_at AS DATE) as created_at_date,
        cast(created_at as TIMESTAMP) as created_at_timestamp,
        day( created_at_date) as created_at_day,
        month( created_at_date) as created_at_month,
        year( created_at_date) as created_at_year,
        dayname( created_at_date) as created_at_dayname,
        updated_at,
        cast(amount/100 as double) as  amount,  -- standerdized as dollar.cent
        cast(amount_captured/100 as double) as amount_captured, 
        cast(amount_authorized/100 as double) as amount_authorized, 
        cast(amount_refunded/100 as double) as amount_refunded ,  
        customer_details
        

    FROM source
)

SELECT * FROM processed
