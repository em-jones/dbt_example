{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('rental_ab1') }}
select
    cast(staff_id as {{ dbt_utils.type_bigint() }}) as staff_id,
    cast(rental_id as {{ dbt_utils.type_bigint() }}) as rental_id,
    cast(customer_id as {{ dbt_utils.type_bigint() }}) as customer_id,
    cast({{ empty_string_to_null('last_update') }} as {{ type_timestamp_without_timezone() }}) as last_update,
    cast({{ empty_string_to_null('rental_date') }} as {{ type_timestamp_without_timezone() }}) as rental_date,
    cast({{ empty_string_to_null('return_date') }} as {{ type_timestamp_without_timezone() }}) as return_date,
    cast(inventory_id as {{ dbt_utils.type_bigint() }}) as inventory_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('rental_ab1') }}
-- rental
where 1 = 1

