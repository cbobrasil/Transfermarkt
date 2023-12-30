
{{ config(materialized='table') }}

with cte_cards as 
  (
  select    
        game_id
      , club_id      
      , card_type
      , count(*) as event_qtt 
  from    
    {{ ref('stg_game_events') }} 
  where
    type = 'Cards'
  group by
        game_id
      , club_id
      , card_type
  )
select
      ge.game_id
    , ge.competition_id
    , ge.date 
    , ge.home_club_id
    , ge.away_club_id
    , ge.home_club_goals
    , ge.away_club_goals
    , case 
        when cte_cards_home.card_type = 'Yellow card'
        then cte_cards_home.event_qtt 
        else 0 
      end as card_yellow_home_qtt
    , case 
        when cte_cards_home.card_type = 'Red card'
        then cte_cards_home.event_qtt 
        else 0
      end as card_red_home_qtt
    , case 
        when cte_cards_away.card_type = 'Yellow card' 
        then cte_cards_away.event_qtt 
        else 0
      end as card_yellow_away_qtt
    , case 
        when cte_cards_away.card_type = 'Red card'  
        then cte_cards_away.event_qtt 
        else 0
      end as card_red_away_qtt
from     
  {{ ref('stg_games') }} as ge
left join 
  cte_cards as cte_cards_home on ge.game_id = cte_cards_home.game_id and  ge.home_club_id = cte_cards_home.club_id
left join 
  cte_cards as cte_cards_away on ge.game_id = cte_cards_away.game_id and  ge.away_club_id = cte_cards_away.club_id