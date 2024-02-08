{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_payment') }}
select
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['staff_id'], ['staff_id']) }} as staff_id,
    {{ json_extract_scalar('_airbyte_data', ['rental_id'], ['rental_id']) }} as rental_id,
    {{ json_extract_scalar('_airbyte_data', ['payment_id'], ['payment_id']) }} as payment_id,
    {{ json_extract_scalar('_airbyte_data', ['customer_id'], ['customer_id']) }} as customer_id,
    {{ json_extract_scalar('_airbyte_data', ['payment_date'], ['payment_date']) }} as payment_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_payment') }} as table_alias
-- payment
where 1 = 1

