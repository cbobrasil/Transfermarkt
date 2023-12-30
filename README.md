## Transfermarkt DBT Project

This project uses the Transfermarkt database that could be found at https://www.kaggle.com/datasets/davidcariboo/player-scores/versions/322?resource=download

Inside it we have the csv's that are saved on tm/seeds folder

The objective here is to create a model structure to deal with the Transfermarkt data providing tables that could be used to future analisys and prediction. 

### Guide:

- python -m pip install dbt-postgres (https://docs.getdbt.com/docs/core/pip-install)

- dbt init (https://docs.getdbt.com/reference/commands/init)

- dbt seed -s file1 (import the data )

    Problem with dbt seed: 

    https://docs.getdbt.com/reference/resource-configs/column_types

    Added this code to dbt_project.yml:

    seeds:
    tm: 
        appearances:
        +column_types:
            appearance_id: varchar(32)
- 

### About the data
![Transfermarkt Data Diagram](https://github.com/dcaribou/transfermarkt-datasets/blob/master/resources/diagram.svg?raw=true)


https://data.world/dcereijo/player-scores-demo


#### Refreshing data
When we start to refresh data on the next step of the project we need to understand witch data need to be incrementally updated?

- appearances: incremental. It´s the biggest table of the project. Show the information about each player of each game. Goals and assistence done, time played, cards. 
- club_games: incremental
- clubs: full refresh (have one row per club informing data that change with time and is the smallest table on the project)
- competitions: full refresh (have one row per competition)
- game_events: incremental (each event of each game)
- game_lineups: incremental (the line-up of each team for each game)
- games: incremental (don´t need to do a full refresh, better to just add the new games)
- player_valuations: incremental (have information along the time)
- players: full refresh (have mutable informations about each player like the actual club and the value in market)