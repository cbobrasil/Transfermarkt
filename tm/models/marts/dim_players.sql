{{ config(materialized='table') }}

select
      player_id
    , first_name
    , last_name
    , name
    , last_season
    , current_club_id
    , player_code
    , country_of_birth
    , city_of_birth
    , country_of_citizenship
    , sub_position
    , position
    , contract_expiration_date
    , agent_name
    , image_url
    , url
    , current_club_domestic_competition_id
    , current_club_name
from     
  {{ ref('stg_players') }} as p