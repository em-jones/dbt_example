{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('language_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('name'),
        'language_id',
        'last_update',
    ]) }} as _airbyte_language_hashid,
    tmp.*
from {{ ref('language_ab2') }} tmp
-- language
where 1 = 1

