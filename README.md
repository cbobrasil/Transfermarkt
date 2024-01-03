## Transfermarkt DBT Project

This project uses the Transfermarkt database that can be found at https://www.kaggle.com/datasets/davidcariboo/player-scores/versions/322?resource=download

Inside it, we have the csv's that are saved on tm/seeds folder

The objective here is to create a model structure to deal with the Transfermarkt data providing tables that could be used for future analisys and prediction. 

### Guide:

- ```python -m pip install dbt-postgres``` (https://docs.getdbt.com/docs/core/pip-install)

- ```dbt init``` (https://docs.getdbt.com/reference/commands/init)

- ```dbt seed -s file1``` (import the data )

- Problem with dbt seed: 

    https://docs.getdbt.com/reference/resource-configs/column_types

    Added this code to dbt_project.yml:
```
    seeds:
    tm: 
        appearances:
        +column_types:
            appearance_id: varchar(32)
```
- To create the dim_date table
create the ```packages.yml``` file in the same level that ```dbt_project.yml```
```
packages:
  - package: dbt-labs/dbt_utils
    version: 1.1.1
  - package: calogica/dbt_date
    version: 0.9.1
```

run:
```dbt deps```

create dim_dates (the actual macro code) and run it: ```dbt run -s dim_dates ```

font: https://medium.com/indiciumtech/date-dimension-how-to-create-a-practical-and-useful-date-dimension-in-dbt-5ee70a18f3bb

### About the data
![Transfermarkt Data Diagram](https://github.com/dcaribou/transfermarkt-datasets/blob/master/resources/diagram.svg?raw=true)


https://data.world/dcereijo/player-scores-demo

### Next Steps

#### Create schemas for each dbt layer 
We need to split the model folders in this project into different schemas as Postgres db. After that, we should create users and give different access for each schema. 

#### Refreshing data
When we start to refresh data on the next step of the project we need to understand which data needs to be incrementally updated (???)

- appearances: incremental. It´s the biggest table of the project. Show the information about each player of each game. Goals and assistance done, time played, cards. 
- club_games: incremental
- clubs: full refresh (There is one row per club informing data that changes with time and is the smallest table on the project)
- competitions: full refresh (There is one row per competition)
- game_events: incremental (There is one row for each game)
- game_lineups: incremental (There is a line-up of each team for each game)
- games: incremental (don´t need to do a full refresh, better to just add the new games)
- player_valuations: incremental (have information along the time)
- players: full refresh (have mutable information about each player like the actual club and the value in the market)


#### Snapshots
We will take snapshots of the changes for the full refresh tables. That way we can keep the the history of this table.
