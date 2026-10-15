# ==============================================================================
# 09 - Supervised learning: decision tree on the Titanic data
# ------------------------------------------------------------------------------
# Data   : data/titanic.csv
# Goal   : predict whether a passenger survived (Yes / No)
# Topics : classification trees with rpart, train / test split,
#          accuracy and confusion matrix,
#          classification tree vs regression tree
# Needs  : install.packages(c("rpart", "rpart.plot"))
# ==============================================================================

rm(list = ls())

library(rpart)
library(rpart.plot)

titanic <- read.csv("data/titanic.csv",
                    header = TRUE, sep = ",", dec = ".",
                    stringsAsFactors = TRUE)

# ---- Preprocessing ------------------------------------------------------------
# The name is unique for every passenger, so it cannot help to predict
# survival for new people. Remove it.
titanic$Name <- NULL

# We want to predict a category, not a number, so Survived becomes a factor.
titanic$Survived <- factor(titanic$Survived, levels = c(0, 1), labels = c("No", "Yes"))
str(titanic)

# ---- Train / test split -------------------------------------------------------
# A model must be judged on data it has never seen.
#   training set (80 %) -> used to build the tree
#   test set     (20 %) -> plays the role of new passengers
# Taking the first 80 % of the rows is not a good idea: if the file is sorted
# in some way, the two sets would be different. Shuffle the rows instead.
set.seed(123)                                    # same random split every run
n_train <- round(0.80 * nrow(titanic))
index   <- sample(1:nrow(titanic), size = n_train, replace = FALSE)

train <- titanic[index, ]
test  <- titanic[-index, ]
c(train = nrow(train), test = nrow(test))

# ---- Classification tree ------------------------------------------------------
# method = "class" builds a CLASSIFICATION tree (the target is a category).
# The control parameters limit how big the tree can grow:
#   maxdepth  - maximum number of levels
#   minsplit  - minimum observations in a node before trying a split
#   minbucket - minimum observations in a leaf
#   cp        - minimum improvement a split must give to be kept
tree <- rpart(Survived ~ .,
              data    = train,
              method  = "class",
              control = rpart.control(maxdepth  = 3,
                                      minsplit  = 20,
                                      minbucket = 7,
                                      cp        = 0.01))

prp(tree, type = 2, extra = 104, faclen = 0, box.palette = "RdGn")
# The first split is on Sex: being female is the strongest predictor.

# ---- Evaluation on the test set -----------------------------------------------
# type = "class" returns the predicted label. Without it, predict() returns
# the probability of each class.
predictions <- predict(tree, newdata = test, type = "class")

accuracy <- mean(predictions == test$Survived)
accuracy                                         # ~0.82 with seed 123

table(Actual = test$Survived, Predicted = predictions)

# ---- Classification tree vs regression tree -----------------------------------
# If Survived is left as the number 0/1, rpart builds a REGRESSION tree
# (method = "anova"). Each leaf then predicts a number: the mean of Survived
# in that leaf, i.e. the share of survivors.
# Using "anova" when you want classes is a common mistake.
train_num <- train
train_num$Survived <- as.numeric(train_num$Survived == "Yes")

reg_tree <- rpart(Survived ~ .,
                  data    = train_num,
                  method  = "anova",
                  control = rpart.control(maxdepth = 3, minbucket = 7))

prp(reg_tree, type = 2)

prob_survive <- predict(reg_tree, newdata = test)   # numbers between 0 and 1
head(round(prob_survive, 2))

# Turning the numbers into classes with a 0.5 threshold gives the same kind
# of answer as the classification tree
pred_from_reg <- ifelse(prob_survive > 0.5, "Yes", "No")
mean(pred_from_reg == test$Survived)
