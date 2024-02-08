{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('film_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'title',
        adapter.quote('length'),
        'rating',
        'film_id',
        'fulltext',
        'description',
        'language_id',
        'last_update',
        'rental_rate',
        'release_year',
        'rental_duration',
        'replacement_cost',
        array_to_string('special_features'),
    ]) }} as _airbyte_film_hashid,
    tmp.*
from {{ ref('film_ab2') }} tmp
-- film
where 1 = 1

