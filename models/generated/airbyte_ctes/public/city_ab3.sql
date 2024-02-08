{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('city_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'city',
        'city_id',
        'country_id',
        'last_update',
    ]) }} as _airbyte_city_hashid,
    tmp.*
from {{ ref('city_ab2') }} tmp
-- city
where 1 = 1

