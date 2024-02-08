{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('actor_info_ab1') }}
select
    cast(actor_id as {{ dbt_utils.type_bigint() }}) as actor_id,
    cast(film_info as {{ dbt_utils.type_string() }}) as film_info,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('actor_info_ab1') }}
-- actor_info
where 1 = 1

