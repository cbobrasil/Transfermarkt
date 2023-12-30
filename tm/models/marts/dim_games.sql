{{ config(materialized='table') }}


select
      g.game_id
    , g.competition_id
    , g.season
    , g.round
    , g.date
    , g.home_club_id
    , g.away_club_id
    , g.home_club_position
    , g.away_club_position
    , g.home_club_manager_name
    , g.away_club_manager_name
    , g.stadium
    , g.attendance
    , g.referee
    , g.url
    , g.home_club_formation
    , g.away_club_formation
    , g.home_club_name
    , g.away_club_name
    , g.aggregate
    , g.competition_type
from    
    {{ ref('stg_games') }} as g 