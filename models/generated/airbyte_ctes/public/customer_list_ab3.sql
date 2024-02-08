{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customer_list_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'sid',
        'city',
        adapter.quote('name'),
        'notes',
        'phone',
        'address',
        'country',
        adapter.quote('zip code'),
    ]) }} as _airbyte_customer_list_hashid,
    tmp.*
from {{ ref('customer_list_ab2') }} tmp
-- customer_list
where 1 = 1

