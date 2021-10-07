{{ config(
    materialized = 'incremental',
    unique_key = 'page_view_id'
) }}

-- unique_key in config changes the SQL from INSERT to MERGE using the unique_key (MERGE may be too expensive for big datasets so we might not want to use it)

with events as (
    select * from {{ source('snowplow', 'events') }}

    {% if is_incremental() %} -- checks for conditions: 1. does model already exist as a table? 2. materialized = 'incremental'? 3. no --full-refresh flag passed?

    -- where last_updated is 3 days ago to account for delays, lag in data, etc. However duplicates could be there, so setting the unique_key parameter into config will solve this.
    -- 3 days generic good timeframe to catch 99.9% of data
    where last_updated >= (select dateadd('day', -3, max(last-updated)) from {{ this }})

    {% endif %}
)

select * from events

-- the full-refresh flag does a full load
-- we can perform a --full-refresh once a week to align

