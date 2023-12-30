
{{ config(materialized='table') }}

select
      competition_id
    , competition_code
    , name
    , sub_type
    , type
    , country_id
    , country_name
    , domestic_league_code
    , confederation
    , url
from    
    {{ ref('competitions') }}