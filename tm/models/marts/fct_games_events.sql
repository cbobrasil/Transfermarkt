
{{ config(materialized='table') }}

select 
    {{ dbt_utils.generate_surrogate_key(['game_event_id','sub_type_event']) }} as game_sub_type_event_id
    , game_event_id
    , game_id
    , club_id  
    , player_id
    , minute
    , type
    , sub_type
    , sub_type_event
    --- COMPLETE WITH THE OTHER SUB_TYPES 
    , case 
        when sub_type_event  like '1. Goal of the Season' then 'Goal'
        when sub_type_event like '%Assist:%' then 'Assited Goal'
        when sub_type_event like '%Assist%' then 'Assited Goal'
        when sub_type_event like '%Assist: Corner%' then 'Assited Goal - Corner'
        when sub_type_event like '%Assist: Cross%' then 'Assited Goal - Cross'
        when sub_type_event like '%Assist: Fouled Played%' then 'Assited Goal - Fouled Played'
        when sub_type_event like '%Assist: Free Kick%' then 'Assited Goal - Free Kick'
        when sub_type_event like '%Assist: Handball%' then 'Assited Goal - Handball'
        when sub_type_event like '%Assist: Header%' then 'Assited Goal - Header'
        when sub_type_event like '%Assist: Pass%' then 'Assited Goal - Pass'
        when sub_type_event like '%Assist: Shot on goal%' then 'Assited Goal - Shot on goal'
        when sub_type_event like '%Assist: Without assist%' then 'Assited Goal - Without assist'
        when sub_type_event like '%Assist: Without assist%' then 'Assited Goal - Without assist'
        end as sub_type_event_2
--        when sub_type_event like '%Assist:%' then 'Assited Goal'
    , player_in_id
    , player_assist_id
from 
    {{ ref('stg_game_events') }}