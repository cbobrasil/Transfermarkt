
{{ config(materialized='table') }}

with cte_game_events as 
(select
      game_event_id
    , date
    , game_id
    , minute
    , type
    , club_id
    , player_id
    , substring(description, 2,8000)  as sub_type
    , case
        when description like '%Yellow%' or description like '%yellow%' then 	'Yellow card'
        when  description like '%Red%' then 	'Red card'
      else 'Not Card' end as card_type
    , player_in_id
    , player_assist_id
from    
    {{ ref('game_events') }}
)
, cte_array as 
(select 
   *
  , string_to_array(sub_type,',') as sub_type_array
from    
    cte_game_events 
)
select    
      game_event_id
    , game_id
    , club_id  
    , player_id
    , minute
    , type
    , sub_type
    , unnest(sub_type_array) as sub_type_event 
    , player_in_id
    , player_assist_id
from 
  cte_array