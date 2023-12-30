
{{ config(materialized='table') }}

select
     {{ dbt_utils.generate_surrogate_key(['player_id','date']) }} as player_val_id
    , player_id
    , date
    , market_value_in_eur
    , current_club_id
from    
    {{ ref('player_valuations') }}