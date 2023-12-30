
{{ config(materialized='table') }}

select
      game_lineups_id
    , game_id
    , club_id
    , type
    , number
    , player_id
    , player_name
    , team_captain
    , position
from    
    {{ ref('game_lineups') }}