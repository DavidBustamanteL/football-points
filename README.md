# Football League Tables under 2- and 3-Point Systems

This project uses football match data from <a href="https://www.football-data.co.uk/" target="_blank" rel="noopener noreferrer">football-data.co.uk</a> to recreate league tables for UEFA’s Top 5 leagues and compare champions under two different point systems:

- 3 points for a win
- 2 points for a win

The project demonstrates how football match data can be obtained from online data sources in R and used to compare league outcomes under different point-awarding rules.

## Leagues Covered

The analysis includes:

- Premier League (England) 
- La Liga (Spain)
- Serie A (Italy)
- Bundesliga (Germany)
- Ligue 1 (France)

## Seasons Covered

The analysis begins with the 1995/96 season, when the 3-point-for-a-win system was adopted following its successful implementation at the 1994 FIFA World Cup.

## Required R Packages

```r
library(tidyverse)
library(magrittr)
```

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

## Results

There is no evidence that the change in the points-awarding system would have produced substantially different outcomes. Across the 150 seasons analyzed, only 7 seasons (4.67%) would have had a different winner. This occurs especially when the difference in the number of wins between first and second place is minimal and the second-placed team has more draws. In such cases, the two-point system may produce a different winner.

| Season    | League  | Actual champion | Points under 3-pt system | Champion under 2-pt system | Points under 2-pt system |
|-----------|---------|-----------------|--------------------------|----------------------------|--------------------------|
| 2018/2019 | England | Manchester City | 98                       | Liverpool                  | 67                       |
| 1997/1998 | France  | Lens            | 68                       | Metz                       | 48                       |
| 2000/2001 | France  | Nantes          | 68                       | Lyon                       | 47                       |
| 2022/2023 | France  | PSG             | 85                       | Lens                       | 59                       |
| 1999/2000 | Germany | Bayern Munich   | 73                       | Leverkusen                 | 52                       |
| 2000/2001 | Germany | Bayern Munich   | 63                       | Schalke 04                 | 44                       |
| 2019/2020 | Italy   | Juventus        | 83                       | Inter Milano               | 58                       |

## Research on the topic

Extensive research has examined whether this change made the sport more interesting, for example by increasing competitiveness or intensity, and whether it substantially increased the number of goals scored. However, no clear evidence has been found.
