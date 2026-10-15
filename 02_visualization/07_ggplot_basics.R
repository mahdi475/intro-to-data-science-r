# ==============================================================================
# 07 - Visualisation with ggplot2: bar charts, histograms, scatter plots
# ------------------------------------------------------------------------------
# Data   : data/titanic.csv
# Topics : the ggplot grammar (data + aes + geom + labs), fill vs colour,
#          stacked vs proportional bars, histograms, scatter plots, jitter
# Needs  : install.packages("ggplot2")
# ==============================================================================

library(ggplot2)

titanic <- read.csv("data/titanic.csv",
                    header = TRUE, sep = ",", dec = ".",
                    stringsAsFactors = TRUE)

# Survived and Pclass are stored as numbers but they are really categories,
# so turning them into factors gives cleaner axes and legends.
titanic$Survived <- factor(titanic$Survived, levels = c(0, 1), labels = c("No", "Yes"))
titanic$Pclass   <- factor(titanic$Pclass)

# ---- Bar charts: categorical variables ----------------------------------------
# Number of passengers by sex
ggplot(titanic, aes(x = Sex)) +
  geom_bar()

# Number of passengers in each class, with colours and labels.
#   fill   = colour inside the bars
#   colour = colour of the border
ggplot(titanic, aes(x = Pclass)) +
  geom_bar(fill = "gold", colour = "navy") +
  labs(x = "Passenger class", y = "Number of passengers",
       title = "Passengers per class")

# Use a second variable to colour the bars: survival in each class
ggplot(titanic, aes(x = Pclass, fill = Survived)) +
  geom_bar() +
  labs(x = "Passenger class", y = "Number of passengers",
       title = "Survival by passenger class", fill = "Survived")

# Did survival depend on sex?
# position = "fill" makes every bar the same height, so the bars show
# proportions instead of counts.
ggplot(titanic, aes(x = Sex, fill = Survived)) +
  geom_bar(colour = "black", position = "fill") +
  labs(x = "Sex", y = "Proportion",
       title = "Survival by sex", fill = "Survived")
# -> about 74 % of the women survived, compared with about 19 % of the men

# ---- Histograms: continuous variables -----------------------------------------
# Age is continuous, so it is grouped into bins
ggplot(titanic, aes(x = Age)) +
  geom_histogram(bins = 30, fill = "gold", colour = "navy") +
  labs(x = "Age", y = "Number of passengers", title = "Age distribution")

# Did survival depend on age?
ggplot(titanic, aes(x = Age, fill = Survived)) +
  geom_histogram(bins = 30, colour = "black") +
  labs(x = "Age", y = "Number of passengers",
       title = "Age distribution by survival", fill = "Survived")

# Same plot with proportions: easier to compare age groups.
# 5-year bins starting at 0 avoid empty bins, which "fill" cannot draw.
ggplot(titanic, aes(x = Age, fill = Survived)) +
  geom_histogram(binwidth = 5, boundary = 0, colour = "black", position = "fill") +
  labs(x = "Age", y = "Proportion",
       title = "Share of survivors by age", fill = "Survived")
# -> young children had the highest survival rate

# ---- Scatter plots: two numeric variables -------------------------------------
# Relationship between age and fare
ggplot(titanic, aes(x = Age, y = Fare)) +
  geom_point(colour = "navy") +
  labs(x = "Age", y = "Fare", title = "Age vs fare")

# Colour the points by survival. geom_jitter() adds a little random noise so
# overlapping points become visible.
ggplot(titanic, aes(x = Age, y = Fare, colour = Survived)) +
  geom_jitter(width = 1, height = 0) +
  labs(x = "Age", y = "Fare", title = "Age vs fare by survival", colour = "Survived")
# -> passengers who paid high fares survived more often
