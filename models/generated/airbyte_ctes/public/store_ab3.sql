{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('store_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'store_id',
        'address_id',
        'last_update',
        'manager_staff_id',
    ]) }} as _airbyte_store_hashid,
    tmp.*
from {{ ref('store_ab2') }} tmp
-- store
where 1 = 1

