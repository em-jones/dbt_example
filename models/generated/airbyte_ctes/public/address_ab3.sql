{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'phone',
        'address',
        'city_id',
        'address2',
        'district',
        'address_id',
        'last_update',
        'postal_code',
    ]) }} as _airbyte_address_hashid,
    tmp.*
from {{ ref('address_ab2') }} tmp
-- address
where 1 = 1

