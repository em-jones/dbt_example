{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_film_list') }}
select
    {{ json_extract_scalar('_airbyte_data', ['fid'], ['fid']) }} as fid,
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['actors'], ['actors']) }} as actors,
    {{ json_extract_scalar('_airbyte_data', ['length'], ['length']) }} as {{ adapter.quote('length') }},
    {{ json_extract_scalar('_airbyte_data', ['rating'], ['rating']) }} as rating,
    {{ json_extract_scalar('_airbyte_data', ['category'], ['category']) }} as category,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_film_list') }} as table_alias
-- film_list
where 1 = 1

