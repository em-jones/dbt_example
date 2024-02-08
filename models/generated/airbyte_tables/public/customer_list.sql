{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='customer_list_scd'
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
-- depends_on: {{ ref('customer_list_ab3') }}
select
    {{ adapter.quote('id') }},
    sid,
    city,
    {{ adapter.quote('name') }},
    notes,
    phone,
    address,
    country,
    {{ adapter.quote('zip code') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customer_list_hashid
from {{ ref('customer_list_ab3') }}
-- customer_list from {{ source('public', '_airbyte_raw_customer_list') }}
where 1 = 1

