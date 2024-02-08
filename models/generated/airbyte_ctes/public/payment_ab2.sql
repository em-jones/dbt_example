{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_ab1') }}
select
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(staff_id as {{ dbt_utils.type_bigint() }}) as staff_id,
    cast(rental_id as {{ dbt_utils.type_bigint() }}) as rental_id,
    cast(payment_id as {{ dbt_utils.type_bigint() }}) as payment_id,
    cast(customer_id as {{ dbt_utils.type_bigint() }}) as customer_id,
    cast({{ empty_string_to_null('payment_date') }} as {{ type_timestamp_without_timezone() }}) as payment_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_ab1') }}
-- payment
where 1 = 1

