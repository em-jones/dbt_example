{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customer_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'email',
        'active',
        'store_id',
        'last_name',
        boolean_to_string('activebool'),
        'address_id',
        'first_name',
        'create_date',
        'customer_id',
        'last_update',
    ]) }} as _airbyte_customer_hashid,
    tmp.*
from {{ ref('customer_ab2') }} tmp
-- customer
where 1 = 1

