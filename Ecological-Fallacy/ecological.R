# install.packages('mlmRev')
library(mlmRev)

dta <- Chem97
#str(dta)

score.region <- aggregate(score ~ lea, data = dta, FUN = mean)
gcsescore.region <- aggregate(gcsescore ~ lea, data = dta, FUN = mean)
dta.region <- data.frame(score = score.region$score,
                         gcsescore = gcsescore.region$gcsescore)

score.school <- aggregate(score ~ school, data = dta, FUN = mean)
gcsescore.school <- aggregate(gcsescore ~ school, data = dta, FUN = mean)
dta.school <- data.frame(score = score.school$score,
                         gcsescore = gcsescore.school$gcsescore)
# str(dta.school)


lm.student <- lm(gcsescore ~ score, data = dta)
lm.school <- lm(gcsescore ~ score, data = dta.school)
lm.region <- lm(gcsescore ~ score, data = dta.region)

# a test
#par(mfcol = c(1, 3))
#plot(gcsescore ~ score, data = dta)
#abline(lm.student, col = 2, lty = 2)
#plot(gcsescore ~ score, data = dta.school)
#abline(lm.school, col = 2, lty = 2)
#plot(gcsescore ~ score, data = dta.region)
#abline(lm.region, col = 2, lty = 2)

# use ggplot
library(ggplot2)

# 
student <- ggplot(data = dta, aes(x = score, y = gcsescore)) +
  geom_point(data = dta.school, aes(x = score, y = gcsescore),
             pch = 19, cex = 0.5, col = "gray95") +
  geom_point(data = dta.region, aes(x = score, y = gcsescore),
             pch = 19, cex = 0.5, col = "gray95") +
  geom_point(pch = 19, cex = 0.5) +
  stat_smooth(data = dta.school, aes(x = score, y = gcsescore),
              method = "lm", se = F, lty = 2, col = "lightblue") +
  stat_smooth(data = dta.region, aes(x = score, y = gcsescore),
              method = "lm", se = F, lty = 2, col = "lightblue") +
  stat_smooth(data = dta, method = "lm", se = F) +
  labs(x = "Score of chemistry", y = "Total score", title = "Student") +
  xlim(0, 10) + ylim(0, 8) +
  theme(aspect.ratio = 1) +
  theme_bw()


#
school <- ggplot(data = dta.school, aes(x = score, y = gcsescore)) +
  geom_point(data = dta, aes(x = score, y = gcsescore),
             pch = 19, cex = 0.5, col = "gray95") +
  geom_point(data = dta.region, aes(x = score, y = gcsescore),
             pch = 19, cex = 0.5, col = "gray95") +
  geom_point(pch = 19, cex = 0.5) +
  stat_smooth(data = dta, aes(x = score, y = gcsescore),
              method = "lm", se = F, lty = 2, col = "lightblue") +
  stat_smooth(data = dta.region, aes(x = score, y = gcsescore),
              method = "lm", se = F, lty = 2, col = "lightblue") +
  stat_smooth(data = dta.school, method = "lm", se = F) +
  labs(x = "Score of chemistry", y = "Total score", title = "School") +
  xlim(0, 10) + ylim(0, 8) +
  theme(aspect.ratio = 1) +
  theme_bw()



#
region <- ggplot(data = dta.region, aes(x = score, y = gcsescore)) +
  geom_point(data = dta, aes(x = score, y = gcsescore),
             pch = 19, cex = 0.5, col = "gray95") +
  geom_point(data = dta.school, aes(x = score, y = gcsescore),
             pch = 19,  cex = 0.5, col = "gray95") +
  geom_point(pch = 19, cex = 0.5) +
  stat_smooth(data = dta, aes(x = score, y = gcsescore),
              method = "lm", se = F, lty = 2, col = "lightblue") +
  stat_smooth(data = dta.school, aes(x = score, y = gcsescore),
              method = "lm", se = F, lty = 2, col = "lightblue") +
  stat_smooth(data = dta.region, method = "lm", se = F) +
  labs(x = "Score of chemistry", y = "Total score", title = "Region") +
  xlim(0, 10) + ylim(0, 8) +
  theme(aspect.ratio = 1) +
  theme_bw()



#
round(with(dta, cor(x = score, y = gcsescore)), 2)
round(summary(lm.student)$r.square, 2)


student <- student + annotate("text", x = 8, y = 1.5,
 label = "phi==0.66~\n~R^{2}==0.44", parse = T, size = 6)


#
round(with(dta.school, cor(x = score, y = gcsescore)), 2)
round(summary(lm.school)$r.square, 2)

school <- school + annotate("text", x = 8, y = 1.5,
 label = "phi==0.70~\n~R^{2}==0.49", parse = T, size = 6)


#
round(with(dta.region, cor(x = score, y = gcsescore)), 2)
round(summary(lm.region)$r.square, 2)

region <- region + annotate("text", x = 8, y = 1.5,
 label = "phi==0.77~\n~R^{2}==0.60", parse = T, size = 6)

#student
#school
#region





