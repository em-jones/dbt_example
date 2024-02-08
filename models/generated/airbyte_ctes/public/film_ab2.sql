{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('film_ab1') }}
select
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast({{ adapter.quote('length') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('length') }},
    cast(rating as {{ dbt_utils.type_string() }}) as rating,
    cast(film_id as {{ dbt_utils.type_bigint() }}) as film_id,
    cast(fulltext as {{ dbt_utils.type_string() }}) as fulltext,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(language_id as {{ dbt_utils.type_bigint() }}) as language_id,
    cast({{ empty_string_to_null('last_update') }} as {{ type_timestamp_without_timezone() }}) as last_update,
    cast(rental_rate as {{ dbt_utils.type_float() }}) as rental_rate,
    cast(release_year as {{ dbt_utils.type_string() }}) as release_year,
    cast(rental_duration as {{ dbt_utils.type_bigint() }}) as rental_duration,
    cast(replacement_cost as {{ dbt_utils.type_float() }}) as replacement_cost,
    special_features,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('film_ab1') }}
-- film
where 1 = 1

