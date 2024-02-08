{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('address_ab1') }}
select
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(city_id as {{ dbt_utils.type_bigint() }}) as city_id,
    cast(address2 as {{ dbt_utils.type_string() }}) as address2,
    cast(district as {{ dbt_utils.type_string() }}) as district,
    cast(address_id as {{ dbt_utils.type_bigint() }}) as address_id,
    cast({{ empty_string_to_null('last_update') }} as {{ type_timestamp_without_timezone() }}) as last_update,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('address_ab1') }}
-- address
where 1 = 1

