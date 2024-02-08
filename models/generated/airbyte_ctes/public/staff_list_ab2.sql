{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('staff_list_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('id') }},
    cast(sid as {{ dbt_utils.type_bigint() }}) as sid,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast({{ adapter.quote('zip code') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('zip code') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('staff_list_ab1') }}
-- staff_list
where 1 = 1

