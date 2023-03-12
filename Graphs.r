library(ggplot2)
library(dplyr)
theme_set(
  theme_light() + theme(
    plot.title = element_text(size = 25),
    plot.title.position = "plot",
    text = element_text(family = "Times New Roman", size = 15)
  )
)
update_geom_defaults("point", list(
  size = 3,
  shape = 19,
  color = 4
))

#survey_dat <- read.csv()
mh_score = mean(survey_dat$h_score)

ggplot(survey_dat) +
  geom_boxplot(aes(grp, h_score, color = grp)) + 
  geom_jitter(aes(grp, h_score, color = grp), width = 0.2, size = 2.5) +
  labs(
    title = "Boxplot of health score of each treatment group",
    x = "Treatment Group",
    y = "Health Score") + 
  theme(legend.position = "none") +
  geom_hline(yintercept = mh_score)


age <- survey_dat$age
hist(age)


ggplot(df, aes(x=D, y=h_score)) + 
  geom_point() +
  labs(
    title = "D-score vs. Health Score",
    x = "D-score",
    y = "Health Score") +
  theme(legend.title=element_blank()) +
  geom_smooth(method="lm", se=TRUE, fill=NA,
                  formula=y ~ poly(x, 2, raw=TRUE), colour="red")

mdf_hscore = mean(df$h_score)

ggplot(df) +
  geom_boxplot(aes(grp, h_score, color = grp)) + 
  geom_jitter(aes(grp, h_score, color = grp), width = 0.2, size = 2.5) +
  labs(
    title = "Boxplot of health score of each treatment group",
    x = "Treatment Group",
    y = "Health Score") + 
  theme(legend.position = "none") +
  geom_hline(yintercept = mdf_hscore)

mdf_D = mean(df$D)
ggplot(df) +
  geom_boxplot(aes(grp, D, color = grp)) + 
  geom_jitter(aes(grp, D, color = grp), width = 0.2, size = 2.5) +
  labs(
    title = "Boxplot of D-score of each treatment group",
    x = "Treatment Group",
    y = "D-score") + 
  theme(legend.position = "none") +
  geom_hline(yintercept = mdf_D)



