# Football League Tables under 2- and 3-Point Systems

This project uses football match data from [football-data.co.uk](https://www.football-data.co.uk/) to recreate league tables for UEFA’s Top 5 leagues and compare champions under two different point systems:

- 3 points for a win
- 2 points for a win

The goal is to examine whether league winners would have changed under the older 2-point rule.

## Leagues Covered

The analysis includes:

- England 
- Spain 
- Italy 
- Germany 
- France 

## Seasons Covered

The analysis begins with the 1995/96 season, when the 3-point-for-a-win system was adopted following its successful implementation at the 1994 FIFA World Cup.

## What the Code Does

The script:

1. Defines the selected leagues and seasons.
2. Downloads match-level data directly from football-data.co.uk.
3. Keeps the relevant match information:
   - season
   - league
   - home team
   - away team
   - home goals
   - visitor goals
4. Builds league tables under a chosen points rule.
5. Creates separate tables for:
   - the current 3-point system
   - the older 2-point system
6. Compares the champions under both systems.
7. Identifies seasons where the champion would have changed.
8. Calculates how often this happens.

## Required R Packages

```r
library(tidyverse)
library(magrittr)
```
