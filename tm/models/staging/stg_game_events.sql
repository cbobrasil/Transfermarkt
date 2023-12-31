
{{ config(materialized='table') }}

select
      game_event_id
    , date
    , game_id
    , minute
    , type
    , club_id
    , player_id
    , substring(description, 2,8000)  as sub_type
    , player_in_id
    , player_assist_id
from    
    {{ ref('game_events') }}