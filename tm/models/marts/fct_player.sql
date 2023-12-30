
select
      player_id
    , current_club_id
    , date_of_birth
    , foot
    , height_in_cm
    , market_value_in_eur
    , highest_market_value_in_eur
from
  {{ ref('stg_players') }} as p