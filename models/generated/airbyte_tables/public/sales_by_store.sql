{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='sales_by_store_scd'
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
-- depends_on: {{ ref('sales_by_store_ab3') }}
select
    store,
    manager,
    total_sales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sales_by_store_hashid
from {{ ref('sales_by_store_ab3') }}
-- sales_by_store from {{ source('public', '_airbyte_raw_sales_by_store') }}
where 1 = 1

