{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('film_actor_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'film_id',
        'actor_id',
        'last_update',
    ]) }} as _airbyte_film_actor_hashid,
    tmp.*
from {{ ref('film_actor_ab2') }} tmp
-- film_actor
where 1 = 1

