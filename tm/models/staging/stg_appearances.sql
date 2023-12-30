
{{ config(materialized='table') }}

select
      appearance_id
    , game_id
    , player_id
    , player_club_id
    , player_current_club_id
    , date
    , player_name
    , competition_id
    , yellow_cards
    , red_cards
    , goals
    , assists
    , minutes_played
from    
    {{ ref('appearances') }}