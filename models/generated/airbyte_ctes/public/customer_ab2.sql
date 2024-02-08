{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customer_ab1') }}
select
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(active as {{ dbt_utils.type_bigint() }}) as active,
    cast(store_id as {{ dbt_utils.type_bigint() }}) as store_id,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    {{ cast_to_boolean('activebool') }} as activebool,
    cast(address_id as {{ dbt_utils.type_bigint() }}) as address_id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast({{ empty_string_to_null('create_date') }} as {{ type_date() }}) as create_date,
    cast(customer_id as {{ dbt_utils.type_bigint() }}) as customer_id,
    cast({{ empty_string_to_null('last_update') }} as {{ type_timestamp_without_timezone() }}) as last_update,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customer_ab1') }}
-- customer
where 1 = 1

