{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_staff') }}
select
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['picture'], ['picture']) }} as picture,
    {{ json_extract_scalar('_airbyte_data', ['password'], ['password']) }} as {{ adapter.quote('password') }},
    {{ json_extract_scalar('_airbyte_data', ['staff_id'], ['staff_id']) }} as staff_id,
    {{ json_extract_scalar('_airbyte_data', ['store_id'], ['store_id']) }} as store_id,
    {{ json_extract_scalar('_airbyte_data', ['username'], ['username']) }} as username,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['address_id'], ['address_id']) }} as address_id,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['last_update'], ['last_update']) }} as last_update,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_staff') }} as table_alias
-- staff
where 1 = 1

