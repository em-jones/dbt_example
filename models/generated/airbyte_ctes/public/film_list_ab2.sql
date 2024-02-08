{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('film_list_ab1') }}
select
    cast(fid as {{ dbt_utils.type_bigint() }}) as fid,
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(actors as {{ dbt_utils.type_string() }}) as actors,
    cast({{ adapter.quote('length') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('length') }},
    cast(rating as {{ dbt_utils.type_string() }}) as rating,
    cast(category as {{ dbt_utils.type_string() }}) as category,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('film_list_ab1') }}
-- film_list
where 1 = 1

