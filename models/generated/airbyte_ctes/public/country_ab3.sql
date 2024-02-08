{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('country_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'country',
        'country_id',
        'last_update',
    ]) }} as _airbyte_country_hashid,
    tmp.*
from {{ ref('country_ab2') }} tmp
-- country
where 1 = 1

