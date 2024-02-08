{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_store') }}
select
    {{ json_extract_scalar('_airbyte_data', ['store_id'], ['store_id']) }} as store_id,
    {{ json_extract_scalar('_airbyte_data', ['address_id'], ['address_id']) }} as address_id,
    {{ json_extract_scalar('_airbyte_data', ['last_update'], ['last_update']) }} as last_update,
    {{ json_extract_scalar('_airbyte_data', ['manager_staff_id'], ['manager_staff_id']) }} as manager_staff_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_store') }} as table_alias
-- store
where 1 = 1

