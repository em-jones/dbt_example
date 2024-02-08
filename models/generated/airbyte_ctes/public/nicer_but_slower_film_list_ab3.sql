{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('nicer_but_slower_film_list_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'fid',
        'price',
        'title',
        'actors',
        adapter.quote('length'),
        'rating',
        'category',
        'description',
    ]) }} as _airbyte_nicer_but_slower_film_list_hashid,
    tmp.*
from {{ ref('nicer_but_slower_film_list_ab2') }} tmp
-- nicer_but_slower_film_list
where 1 = 1

