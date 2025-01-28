
with source as ( SELECT * FROM {{ ref("payment_request_data")}}),

final as (

    select
        primer_account_id as merchant_id,
        payment_request_id ,
        payment_id,
        payment_instrument_token_id,
        merchant_request_id,
        payment_request_type,
        COALESCE(payment_instrument_vault_intention, 'UNKNOWN') as payment_instrument_vault_intention,
        metadata,
        COALESCE(CURRENCY_CODE, 'UNKNOWN') as currency_code, -- nan present
        created_at,
        cast(amount/100 as double) amount , 
        case when metadata is not null then 'value_provided' else 'no_metadata' end as metadata_status --new categorical column 

        from source
        )

SELECT * FROM final



 


 