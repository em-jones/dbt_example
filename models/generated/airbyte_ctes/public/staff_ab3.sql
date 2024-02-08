{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('staff_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'email',
        boolean_to_string('active'),
        'picture',
        adapter.quote('password'),
        'staff_id',
        'store_id',
        'username',
        'last_name',
        'address_id',
        'first_name',
        'last_update',
    ]) }} as _airbyte_staff_hashid,
    tmp.*
from {{ ref('staff_ab2') }} tmp
-- staff
where 1 = 1

