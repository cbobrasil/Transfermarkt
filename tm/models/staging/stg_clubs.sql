
{{ config(materialized='table') }}

select
       club_id
      , club_code
      , name
      , domestic_competition_id
      , foreigners_number
      , national_team_players
      , stadium_name
      , stadium_seats
      , net_transfer_record
      , coach_name
      , last_season
      , filename
      , url
from    
    {{ ref('clubs') }}