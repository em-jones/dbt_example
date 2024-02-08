{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sales_by_film_category_ab1') }}
select
    cast(category as {{ dbt_utils.type_string() }}) as category,
    cast(total_sales as {{ dbt_utils.type_float() }}) as total_sales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_by_film_category_ab1') }}
-- sales_by_film_category
where 1 = 1

