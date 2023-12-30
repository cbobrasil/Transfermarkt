
{{ config(materialized='table') }}

select
      player_id
    , date
    , datetime
    , dateweek
    , market_value_in_eur
    , current_club_id
    , player_club_domestic_competition_id
from    
    {{ ref('player_valuations') }}