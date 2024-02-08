{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('rental_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'staff_id',
        'rental_id',
        'customer_id',
        'last_update',
        'rental_date',
        'return_date',
        'inventory_id',
    ]) }} as _airbyte_rental_hashid,
    tmp.*
from {{ ref('rental_ab2') }} tmp
-- rental
where 1 = 1

