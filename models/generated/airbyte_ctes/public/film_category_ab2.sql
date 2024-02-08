{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('film_category_ab1') }}
select
    cast(film_id as {{ dbt_utils.type_bigint() }}) as film_id,
    cast(category_id as {{ dbt_utils.type_bigint() }}) as category_id,
    cast({{ empty_string_to_null('last_update') }} as {{ type_timestamp_without_timezone() }}) as last_update,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('film_category_ab1') }}
-- film_category
where 1 = 1

