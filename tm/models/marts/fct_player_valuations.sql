
select
      pv.player_val_id
    , pv.player_id
    , pv.date
    , pv.market_value_in_eur
    , pv.current_club_id
    , p.foot
    , p.height_in_cm
from
  {{ ref('stg_player_valuations') }} as pv
left join 
  {{ ref('stg_players') }} as p on pv.player_id = p.player_id