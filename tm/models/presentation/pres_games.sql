
{{ config(materialized='table') }}

with cte_cards as 
  (
  select    
        game_id
      , club_id      
      , card_color
      , count(*) as event_qtt 
  from    
    {{ ref('fct_games_events') }} 
  where
    type = 'Cards' and card_color is not null 
  group by
        game_id
      , club_id
      , card_color
  )
, cte_goal_time as 
(
  select
      game_id
    , club_id 
    , round(avg(minute),2) as time_avg
  from {{ ref('fct_games_events')}} 
    where type = 'Goals'
    group by
      game_id
    , club_id 
)

select
      ge.game_id
    , ge.date 
    , c.name as competition_name
    , c.country_name as competition_country
    , ge.home_club_name
    , ge.away_club_name
    , ge.home_club_goals
    , cgt_home.time_avg as home_club_time_avg_goals
    , ge.away_club_goals
    , cgt_away.time_avg as away_club_time_avg_goals
    , case 
        when cte_cards_home.card_color = 'Yellow'
        then cte_cards_home.event_qtt 
        else 0 
      end as card_yellow_home_qtt
    , case 
        when cte_cards_home.card_color = 'Red'
        then cte_cards_home.event_qtt 
        else 0
      end as card_red_home_qtt
    , case 
        when cte_cards_away.card_color = 'Yellow' 
        then cte_cards_away.event_qtt 
        else 0
      end as card_yellow_away_qtt
    , case 
        when cte_cards_away.card_color = 'Red'  
        then cte_cards_away.event_qtt 
        else 0
      end as card_red_away_qtt
    , cg.is_win as home_club_win
from     
  {{ ref('stg_games') }} as ge
left join 
  cte_cards as cte_cards_home on ge.game_id = cte_cards_home.game_id and  ge.home_club_id = cte_cards_home.club_id
left join 
  cte_cards as cte_cards_away on ge.game_id = cte_cards_away.game_id and  ge.away_club_id = cte_cards_away.club_id
left join 
    {{ ref('stg_club_games') }} as cg on ge.game_id = cg.game_id  and cg.club_id = ge.home_club_id
left join 
    {{ ref('stg_competitions') }} as c on ge.competition_id = c.competition_id
left join 
    cte_goal_time as cgt_home on cgt_home.game_id = ge.game_id and cgt_home.club_id = ge.home_club_id 
left join 
    cte_goal_time as cgt_away on cgt_away.game_id = ge.game_id and cgt_away.club_id = ge.away_club_id
