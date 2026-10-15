# ==============================================================================
# 08 - Boxplots and facets
# ------------------------------------------------------------------------------
# Data   : data/titanic.csv
# Topics : boxplots, comparing groups, facet_grid(), mean by group
# Needs  : install.packages("ggplot2")
# ==============================================================================

library(ggplot2)

titanic <- read.csv("data/titanic.csv",
                    header = TRUE, sep = ",", dec = ".",
                    stringsAsFactors = TRUE)
titanic$Pclass <- factor(titanic$Pclass)

# ---- Boxplots -----------------------------------------------------------------
# A boxplot shows the median (line), the middle 50 % of the data (box)
# and possible outliers (dots).

# 1. Distribution of age
ggplot(titanic, aes(y = Age)) +
  geom_boxplot(fill = "lightyellow", colour = "navy") +
  labs(x = "", y = "Age", title = "Age distribution")

# 2. One boxplot per sex
ggplot(titanic, aes(x = Sex, y = Age, fill = Sex)) +
  geom_boxplot() +
  labs(x = "", y = "Age", title = "Age distribution by sex")

# 3. One boxplot per passenger class
ggplot(titanic, aes(x = Pclass, y = Age, fill = Pclass)) +
  geom_boxplot() +
  labs(x = "Passenger class", y = "Age", title = "Age distribution by class")
# -> first-class passengers were older on average

# ---- Facets: one small plot per group -----------------------------------------
# 4. Age histogram for each class side by side
ggplot(titanic, aes(x = Age)) +
  geom_histogram(bins = 20, fill = "gold", colour = "navy") +
  facet_grid(. ~ Pclass) +
  labs(x = "Age", y = "Number of passengers", title = "Age distribution per class")

# 5. Age vs fare, one panel per class
ggplot(titanic, aes(x = Age, y = Fare)) +
  geom_point(size = 2, alpha = 0.6) +
  facet_grid(. ~ Pclass) +
  labs(x = "Age", y = "Fare", title = "Age vs fare per class")

# ---- Mean fare per class ------------------------------------------------------
mean(titanic$Fare[titanic$Pclass == 1])   # ~84
mean(titanic$Fare[titanic$Pclass == 2])   # ~21
mean(titanic$Fare[titanic$Pclass == 3])   # ~14

# The same in one line with tapply()
tapply(titanic$Fare, titanic$Pclass, mean)
