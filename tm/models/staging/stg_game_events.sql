
{{ config(materialized='table') }}

select
      game_event_id
    , date
    , game_id
    , minute
    , type
    , club_id
    , player_id
    , description as sub_type
    , case
        when description like '%Yellow%' or description like '%yellow%' then 	'Yellow card'
        when  description like '%Red%' then 	'Red card'
      else 'Not Card' end as card_type
    , player_in_id
    , player_assist_id
from    
    {{ ref('game_events') }}