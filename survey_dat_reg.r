library(ggplot2)
library(dplyr)
theme_set(theme_light()+theme(plot.title = element_text(hjust = 0.5), plot.title.position = "panel", text = element_text(family = "Times New Roman", size = 15)))
update_geom_defaults("point", list(size=3, shape=19, color=4))

df <- readr::read_csv("processed_dat2.csv")


df |> 
  mutate(grp = factor(grp,
                      levels = c("Control", "Unhealthy", "Healthy")),
         citytier = factor(citytier),
         water
  ) |> select(h_score, age, grp, citytier, fem) -> df


df1 |> 
  mutate(grp = factor(grp,
                      levels = c("Control", "Unhealthy", "Healthy")),
         citytier = factor(citytier),
         Dsq = D^2) |>
  select(h_score, age, grp, citytier, fem) -> df1

survey_dat <- rbind(df1, df)

summary(lm(h_score ~ grp, survey_dat))
summary(lm(h_score ~ grp + age + citytier + fem, survey_dat))


