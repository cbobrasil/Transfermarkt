{{ config(materialized='table') }}

select
        club_id
      , club_code
      , name
      , domestic_competition_id
      , squad_size
      , average_age
      , foreigners_number
      , foreigners_percentage
      , national_team_players
      , stadium_name
      , stadium_seats
      , net_transfer_record
      , coach_name
      , last_season
      , filename
      , url
from
  {{ ref('stg_players') }} as p