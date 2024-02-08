{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('actor_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'actor_id',
        'last_name',
        'first_name',
        'last_update',
    ]) }} as _airbyte_actor_hashid,
    tmp.*
from {{ ref('actor_ab2') }} tmp
-- actor
where 1 = 1

