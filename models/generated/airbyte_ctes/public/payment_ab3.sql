{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'amount',
        'staff_id',
        'rental_id',
        'payment_id',
        'customer_id',
        'payment_date',
    ]) }} as _airbyte_payment_hashid,
    tmp.*
from {{ ref('payment_ab2') }} tmp
-- payment
where 1 = 1

