{{ config(
    materialized='incremental'
)}}

with events as (
    select * from {{ source('snowplow', 'events') }}

    {% if is_incremental() %} -- checks for conditions: 1. does model already exist as a table? 2. materialized = 'incremental'? 3. no --full-refresh flag passed?

    where last_updated >= (select max(last_updated) from {{ this }}) -- {{ this }} refers to the current object. This could have an issue if something came in with an earlier last_updated but came in later

    {% endif %}
)

select * from events

-- the full-refresh flag does a full load