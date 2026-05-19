# Deleting mem
rm(list = ls())

# Packages
library(dplyr)
library(magrittr)

# Selecting just the UEFA's Top5 Leagues
leagues = tribble(
  ~league, ~code,
  "England", "E0",
  "Spain",   "SP1",
  "Italy",   "I1",
  "Germany", "D1",
  "France",  "F1"
)

# All seasons since the change in the point-awarding rules
seasons = 1995:2024   # 1995 means 1995/96 and so one in Europe, some LatAm league will pose a small problem with this structure

# prep
make_season_code = function(y) {
  paste0(str_sub(y, 3, 4), str_sub(y + 1, 3, 4))
}

# Importing the data from football-data in the UK
read_matches = function(season_start, league, code) {
  sc = make_season_code(season_start)
  url = paste0("https://www.football-data.co.uk/mmz4281/", sc, "/", code, ".csv")
  
  read_csv(url, show_col_types = FALSE) %>%
    transmute(
      season = paste0(season_start, "/", season_start + 1),
      league = league,
      home = HomeTeam,
      away = AwayTeam,
      home_goals = FTHG,
      visitor_goals = FTAG
    ) %>%
    filter(!is.na(home_goals), !is.na(visitor_goals))
}

matches = crossing(seasons, leagues) %>%
  pmap_dfr(~ read_matches(..1, ..2, ..3))

# computing a league table under any points rule:
make_table = function(df, win_points = 3) {
  
  home = df %>%
    transmute(
      season, league,
      team = home,
      played = 1,
      wins = as.integer(home_goals > visitor_goals),
      draws = as.integer(home_goals == visitor_goals),
      losses = as.integer(home_goals < visitor_goals),
      goals_for = home_goals,
      goals_against = visitor_goals,
      points = case_when(
        home_goals > visitor_goals ~ win_points,
        home_goals == visitor_goals ~ 1,
        TRUE ~ 0
      )
    )
  
  away = df %>%
    transmute(
      season, league,
      team = away,
      played = 1,
      wins = as.integer(visitor_goals > home_goals),
      draws = as.integer(visitor_goals == home_goals),
      losses = as.integer(visitor_goals < home_goals),
      goals_for = visitor_goals,
      goals_against = home_goals,
      points = case_when(
        visitor_goals > home_goals ~ win_points,
        visitor_goals == home_goals ~ 1,
        TRUE ~ 0
      )
    )
  
  bind_rows(home, away) %>%
    group_by(season, league, team) %>%
    summarise(
      played = sum(played),
      wins = sum(wins),
      draws = sum(draws),
      losses = sum(losses),
      goals_for = sum(goals_for),
      goals_against = sum(goals_against),
      goal_diff = goals_for - goals_against,
      points = sum(points),
      .groups = "drop"
    ) %>%
    group_by(season, league) %>%
    arrange(desc(points), desc(goal_diff), desc(goals_for), team, .by_group = TRUE) %>%
    mutate(rank = row_number()) %>%
    ungroup()
}

# Comparing winners under 3- and 2-point rules
table_3pts = make_table(matches, win_points = 3)
table_2pts = make_table(matches, win_points = 2)

champions_3pts = table_3pts %>%
  filter(rank == 1) %>%
  dplyr::select(
    season,
    league,
    real_champion = team,
    points_3 = points
  )

champions_2pts = table_2pts %>%
  filter(rank == 1) %>%
  dplyr::select(
    season,
    league,
    champion_2pts = team,
    points_2 = points
  )

comparison = champions_3pts %>%
  left_join(champions_2pts, by = c("season", "league")) %>%
  mutate(winner_changes = real_champion != champion_2pts)

comparison %<>%
  arrange(league, season)

# Showing seasons with diff. winners
comparison_diff = comparison %>%
  filter(winner_changes)

# Counting how often a diff. winner emerges
comparison %>%
  summarise(
    seasons = n(),
    changes = sum(winner_changes),
    share_changed = changes / seasons,
    .groups = "drop"
  )
