{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('film_category_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'film_id',
        'category_id',
        'last_update',
    ]) }} as _airbyte_film_category_hashid,
    tmp.*
from {{ ref('film_category_ab2') }} tmp
-- film_category
where 1 = 1

