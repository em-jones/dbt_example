{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('inventory_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'film_id',
        'store_id',
        'last_update',
        'inventory_id',
    ]) }} as _airbyte_inventory_hashid,
    tmp.*
from {{ ref('inventory_ab2') }} tmp
-- inventory
where 1 = 1

