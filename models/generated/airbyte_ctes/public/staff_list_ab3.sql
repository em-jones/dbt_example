{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('staff_list_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'sid',
        'city',
        adapter.quote('name'),
        'phone',
        'address',
        'country',
        adapter.quote('zip code'),
    ]) }} as _airbyte_staff_list_hashid,
    tmp.*
from {{ ref('staff_list_ab2') }} tmp
-- staff_list
where 1 = 1

