
with source as ( SELECT * FROM {{ ref("payment_instrument_token_data")}}),

cleaned as 
    (
        select 
        cast(token_id as string)  as token_id, 
        token_type, 
        payment_instrument_type,
        network,
        three_d_secure_authentication

        from source


    )

select * from cleaned