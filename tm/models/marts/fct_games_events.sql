
{{ config(materialized='table') }}

select 
      game_event_id
    , game_id
    , club_id  
    , player_id
    , minute
    , type
    , sub_type
    , case 
        when type = 'Cards' and sub_type like '%Yellow%' then 'Yellow'
        when  type = 'Cards' and sub_type like '%Yellow%' then 'Red'
        else null 
      end as card_color
    , case 
        when type = 'Cards' and sub_type like '%Foul%' then 'Foul'
        when type = 'Cards' and sub_type like '%Mass confro%' then 'Mass Confrontation'
        when type <> 'Cards' then null
        else 'other reasons'
      end as card_reason
    , case
        when type= 'Substitutions' and sub_type like '% Tactical%' then 'Tactical'
        when type= 'Substitutions' and sub_type like '% Not reported%' then 'Not Reported'
        when type <>'Substitutions' then null
        else 'other reasons'
      end as substitutions_reason
    , case 
        when  type = 'Goals' and sub_type like '%Counter attack goal%' then 'Counter attack'
        when  type = 'Goals' and sub_type like '%Direct corner%' then 'Direct corner'
        when  type = 'Goals' and sub_type like '%Solo run%' then 'Solo run'
        when  type = 'Goals' and sub_type like '%Tap-in%' then 'Tap-in'
        when  type = 'Goals' and sub_type like '%Solo run%' then 'Solo run'
        when  type <>'Goals' then null
        else 'Not defined'
      end as goal_type
    , case 
        when type = 'Goals' and  sub_type like '%Assist:%' then true
        when type <> 'Goals' then null 
        else false
      end as assisted_goal 
    , case when type in('Cards','Substitutions') then null
        when type = 'Goals' and sub_type like '%Corner%' then 'Corner'
        when type = 'Goals' and sub_type like '%Cross%' then 'Cross'
        when type = 'Goals' and sub_type like '%Free Kick%' or sub_type like '%Free kick%' then 'Free Kick'
        when type = 'Goals' and sub_type like '%Handball%' then 'Handball'
        when type = 'Goals' and sub_type like '%Header%' then 'Header'
        when type = 'Goals' and sub_type like '%Pass%' then 'Pass'
        when type = 'Goals' and sub_type like '%Shot on goal%' then 'Shot on goal'
        when type = 'Goals' and sub_type like '%Without assist%' then 'Without assist'
        when type = 'Goals' and sub_type like '%Goal-kick%' then 'Goal-kick'
        when type = 'Goals' and sub_type like '%Long distance kick%' then 'Long distance kick'
        when type = 'Goals' and sub_type like '%Direct free kick%' then 'Direct free kick'
        else 'Assistence not defined'
      end as assistence_type 
    , case when sub_type like '%Right-footed%' then 'Right'
        when sub_type like '%Left-footed%' then 'Left'
        else null
      end as goal_foot
    , case 
        when type = 'Goals' and sub_type like '%Penalty%' then true 
        when type <>'Goals' then null
        else false
      end as goal_penalty
    , case 
        when type = 'Goals' and sub_type like '%Deflected shot on goal%' then true 
        when type = 'Goals' and sub_type like '%Own-goal%' then true
        when type <>'Goals' then null
        else false
      end as own_goal
    , player_in_id
    , player_assist_id
from 
    {{ ref('stg_game_events') }}