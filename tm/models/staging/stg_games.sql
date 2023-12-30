
{{ config(materialized='table') }}

select
      game_id
    , competition_id
    , season
    , round
    , date
    , home_club_id
    , away_club_id
    , home_club_goals
    , away_club_goals
    , home_club_position
    , away_club_position
    , home_club_manager_name
    , away_club_manager_name
    , stadium
    , attendance
    , referee
    , url
    , home_club_formation
    , away_club_formation
    , home_club_name
    , away_club_name
    , aggregate
    , competition_type
from    
    {{ ref('games') }}