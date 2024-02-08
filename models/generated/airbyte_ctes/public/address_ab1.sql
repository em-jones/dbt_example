{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_address') }}
select
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['city_id'], ['city_id']) }} as city_id,
    {{ json_extract_scalar('_airbyte_data', ['address2'], ['address2']) }} as address2,
    {{ json_extract_scalar('_airbyte_data', ['district'], ['district']) }} as district,
    {{ json_extract_scalar('_airbyte_data', ['address_id'], ['address_id']) }} as address_id,
    {{ json_extract_scalar('_airbyte_data', ['last_update'], ['last_update']) }} as last_update,
    {{ json_extract_scalar('_airbyte_data', ['postal_code'], ['postal_code']) }} as postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_address') }} as table_alias
-- address
where 1 = 1

