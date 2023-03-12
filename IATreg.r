df <- readr::read_csv("processed_dat.csv")


df |> 
  mutate(grp = factor(grp,
                      levels = c("Control", "Unhealthy", "Healthy")),
         citytier = factor(citytier)
  ) |> select(h_score, age, D, grp, citytier, fem) -> df

