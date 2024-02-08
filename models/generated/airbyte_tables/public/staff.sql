{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='staff_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('staff_ab3') }}
select
    email,
    active,
    picture,
    {{ adapter.quote('password') }},
    staff_id,
    store_id,
    username,
    last_name,
    address_id,
    first_name,
    last_update,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_staff_hashid
from {{ ref('staff_ab3') }}
-- staff from {{ source('public', '_airbyte_raw_staff') }}
where 1 = 1

