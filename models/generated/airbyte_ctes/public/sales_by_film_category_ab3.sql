{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_by_film_category_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'category',
        'total_sales',
    ]) }} as _airbyte_sales_by_film_category_hashid,
    tmp.*
from {{ ref('sales_by_film_category_ab2') }} tmp
-- sales_by_film_category
where 1 = 1

