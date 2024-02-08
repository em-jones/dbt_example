{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_sales_by_store') }}
select
    {{ json_extract_scalar('_airbyte_data', ['store'], ['store']) }} as store,
    {{ json_extract_scalar('_airbyte_data', ['manager'], ['manager']) }} as manager,
    {{ json_extract_scalar('_airbyte_data', ['total_sales'], ['total_sales']) }} as total_sales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_sales_by_store') }} as table_alias
-- sales_by_store
where 1 = 1

