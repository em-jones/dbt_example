{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_film') }}
select
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['length'], ['length']) }} as {{ adapter.quote('length') }},
    {{ json_extract_scalar('_airbyte_data', ['rating'], ['rating']) }} as rating,
    {{ json_extract_scalar('_airbyte_data', ['film_id'], ['film_id']) }} as film_id,
    {{ json_extract_scalar('_airbyte_data', ['fulltext'], ['fulltext']) }} as fulltext,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['language_id'], ['language_id']) }} as language_id,
    {{ json_extract_scalar('_airbyte_data', ['last_update'], ['last_update']) }} as last_update,
    {{ json_extract_scalar('_airbyte_data', ['rental_rate'], ['rental_rate']) }} as rental_rate,
    {{ json_extract_scalar('_airbyte_data', ['release_year'], ['release_year']) }} as release_year,
    {{ json_extract_scalar('_airbyte_data', ['rental_duration'], ['rental_duration']) }} as rental_duration,
    {{ json_extract_scalar('_airbyte_data', ['replacement_cost'], ['replacement_cost']) }} as replacement_cost,
    {{ json_extract_string_array('_airbyte_data', ['special_features'], ['special_features']) }} as special_features,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_film') }} as table_alias
-- film
where 1 = 1

