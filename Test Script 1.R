require(tidyverse)

prostate <-  read.table("Prostate (1).csv", 
                        header = TRUE, sep = ",", na.strings = " ")

round(head(prostate), digits = 3)

# x11()
# pairs(prostate)



mod.vol = lm(lpsa ~ lcavol + age, data = prostate)
# mod.pgg = lm(lpsa ~ pgg45, data=prostate)

# x11(h=7, w=12)
# par(mfrow=c(1,2))

ggplot(data = prostate, aes(x = age, y = lpsa)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(title = "Scatterplot between lpsa and lcavol")

ggsave("Test Plot 1.png")

ggplot(data = prostate, aes(x = pgg45, y = lpsa)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  labs(title = "Scatterplot between lpsa and pgg45")

ggsave("Test Plot 2.png")



# library(rgl)  
# open3d()
# plot3d(prostate$lpsa ~ prostate$lcavol + prostate$pgg45, col="blue")

mod2 =  lm(lpsa ~ lcavol + pgg45, data=prostate)

x1 <- seq(from=-2, to=4, by=.05)
xy1 <- data.frame(expand.grid(lcavol=seq(from=-2, to=4, by=.05), 
                              pgg45=seq(from=0, to=100, by=.5)))
pred <- predict(mod2 ,newdata=xy1)
surface = matrix(pred, nrow=length(x1))

# library(rgl)  
# open3d()
# persp3d(x = seq(from=-2, to=4, by=.05), y = seq(from=0, to=100, by=.5), 
#         z = surface, col = "orange", xlab="lcavol", ylab="pgg45", 
#         zlab="Predicted lpsa")
# points3d(prostate$lpsa ~ prostate$lcavol + prostate$pgg45, col="blue")

# Compare estimated regression corfficients from separate regs vs. multiple

summary(mod.vol)
summary(mod.pgg)
summary(mod2)

cor(prostate)


