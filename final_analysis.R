df1 <- readr::read_csv("processed_dat.csv")
library(t)
library(dplyr)
library(ggplot2)

df |> 
  mutate(grp = factor(grp,
                      levels = c("Control", "Unhealthy", "Healthy")),
                citytier = factor(citytier),
         Dsq = D^2) |> 
  select(h_score, D, age, water, grp, citytier, fem, Dsq) -> df


df |> 
  group_by(grp) |> 
  summarise(mh = mean(h_score), md = mean(D))

df |> ggplot(aes(grp, h_score, color = grp)) + geom_boxplot() + geom_jitter(width = 0.2)
df |> ggplot(aes(grp, D, color = grp)) + geom_boxplot() + geom_jitter(width = 0.2)

ggplot(df, aes(water, h_score)) + geom_point()
ggplot(df, )

summary(lm(h_score ~ grp, df))
summary(lm(D ~ grp, df))
