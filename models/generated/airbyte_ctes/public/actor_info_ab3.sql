{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('actor_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'actor_id',
        'film_info',
        'last_name',
        'first_name',
    ]) }} as _airbyte_actor_info_hashid,
    tmp.*
from {{ ref('actor_info_ab2') }} tmp
-- actor_info
where 1 = 1

