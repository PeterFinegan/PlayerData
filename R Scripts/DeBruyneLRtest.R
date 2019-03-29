app <- read.csv(file = "DeBruyne.csv", header = T, sep = ",")

read(app)

require(smooth)
require(Mcomp)

plot.ts(app$Apps)
#week seasons
Apps - apps

#linearMod <- lm(Apps ~ Seasons, data=app)  # build linear regression model on full data
#print(linearMod)

#scatter.smooth(x=app$Seasons, y=app$Apps, main="Apps ~ Seasons")

#apps_prediction = 2.091-seasons*2020-next season + -4175.273 - coeffcients

#season_predict <- data.frame(Seasons, 2020)

#Apps_predict <- data.frame(Apps, apps_prediction)

#scatter.smooth(x=season_predict, y=Apps_predict, main="Apps_predict ~ seasons_predict")

linearMod <- lm(Value ~ Seasons, data=app)  # build linear regression model on full data
print(linearMod)

scatter.smooth(x=app$Seasons, y=app$Value, main="Value ~ Seasons")

value_prediction = 1.523e+07*2020 + -3.063e+10

Value_predict <- data.frame(rbind(app$Value, value_prediction))

next_season <- data.frame("2020")

season_predict <- data.frame(rbind(app$Seasons, next_season))

scatter.smooth(x=season_predict, y=Value_predict, main="Value_predict ~ seasons_predict")

print(value_prediction)
