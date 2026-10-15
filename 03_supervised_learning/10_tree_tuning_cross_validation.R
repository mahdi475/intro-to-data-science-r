# ==============================================================================
# 10 - Tuning a decision tree with k-fold cross-validation
# ------------------------------------------------------------------------------
# Data   : data/breast_cancer.csv (Breast Cancer Wisconsin Diagnostic, 569 tumours)
# Goal   : predict if a tumour is malignant (M) or benign (B)
# Topics : confusion matrix, accuracy / precision / recall / specificity,
#          hyperparameters, grid search, 5-fold cross-validation
# Needs  : install.packages(c("rpart", "rpart.plot", "tictoc"))
# ==============================================================================

rm(list = ls())

library(rpart)
library(rpart.plot)
library(tictoc)

cancer <- read.csv("data/breast_cancer.csv",
                   header = TRUE, sep = ",", dec = ".",
                   stringsAsFactors = TRUE)

cancer$id <- NULL          # an ID number says nothing about the tumour
dim(cancer)
table(cancer$diagnosis)    # 357 benign, 212 malignant

# ---- Train / test split (80 / 20) ---------------------------------------------
set.seed(1)
n_all <- nrow(cancer)
n_tr  <- round(0.8 * n_all)

index    <- sample(1:n_all, size = n_tr, replace = FALSE)
training <- cancer[index, ]
testing  <- cancer[-index, ]

# ---- Evaluation metrics -------------------------------------------------------
# Positive class = malignant (M).
#
#                 Predicted
#   Actual  |   B    |   M
#   --------|--------|--------
#      B    |   TN   |   FP     FP = false alarm
#      M    |   FN   |   TP     FN = missed cancer
#
# Accuracy    = (TP + TN) / all   share of all predictions that are right
# Precision   = TP / (TP + FP)    when the model says "M", how often is it right?
# Recall      = TP / (TP + FN)    how many of the real "M" cases did we catch?
# Specificity = TN / (TN + FP)    how many of the real "B" cases did we catch?
#
# In medicine a false negative (a missed cancer) is the most dangerous error,
# so recall matters more than precision here.
evaluate <- function(predicted, actual) {
  c(accuracy    = mean(predicted == actual),
    precision   = sum(predicted == "M" & actual == "M") / sum(predicted == "M"),
    recall      = sum(predicted == "M" & actual == "M") / sum(actual == "M"),
    specificity = sum(predicted == "B" & actual == "B") / sum(actual == "B"))
}

# ---- Baseline: tree with default settings -------------------------------------
tree_default <- rpart(diagnosis ~ ., data = training, method = "class")
prp(tree_default, extra = 1)

pred_default <- predict(tree_default, newdata = testing, type = "class")
table(Actual = testing$diagnosis, Predicted = pred_default)
round(evaluate(pred_default, testing$diagnosis), 3)

# ---- Hyperparameters ----------------------------------------------------------
# These settings control how large the tree can grow. A tree that is too deep
# memorises the training data (overfitting) and predicts new data badly.
#   minsplit  - minimum observations in a node before a split is tried
#   minbucket - minimum observations in a leaf
#   maxdepth  - maximum depth of the tree
#   cp        - minimum improvement a split must give to be kept
#
# Which values are best? Try every combination in a grid.
params <- list(minsplit  = seq(from = 2, to = 14, by = 4),
               minbucket = c(2, 4, 6, 8),
               maxdepth  = 2:5,
               cp        = seq(from = 0.0001, to = 0.01, length.out = 6))
grid <- expand.grid(params)
nrow(grid)                 # 4 * 4 * 4 * 6 = 384 combinations

# ---- 5-fold cross-validation on the TRAINING set only -------------------------
# The test set must stay untouched until the very end. To compare the
# combinations we split the training set into 5 folds: each fold is used once
# as a small validation set while the other 4 are used for training.
folds   <- 5
fold_id <- sample(rep(1:folds, length.out = n_tr))   # random fold for each row
table(fold_id)                                       # folds of almost equal size

cv_accuracy <- rep(0, nrow(grid))

tic("grid search")
for (g in 1:nrow(grid)) {
  fold_acc <- rep(0, folds)

  for (k in 1:folds) {
    cv_train <- training[fold_id != k, ]
    cv_valid <- training[fold_id == k, ]

    model <- rpart(diagnosis ~ .,
                   data    = cv_train,
                   method  = "class",
                   control = rpart.control(minsplit  = grid$minsplit[g],
                                           minbucket = grid$minbucket[g],
                                           maxdepth  = grid$maxdepth[g],
                                           cp        = grid$cp[g]))

    pred        <- predict(model, newdata = cv_valid, type = "class")
    fold_acc[k] <- mean(pred == cv_valid$diagnosis)
  }

  cv_accuracy[g] <- mean(fold_acc)
}
toc()

best <- which.max(cv_accuracy)
grid[best, ]
cv_accuracy[best]          # mean validation accuracy of the best combination

# ---- Final model --------------------------------------------------------------
# Train on the whole training set with the best hyperparameters,
# then evaluate ONCE on the test set.
tree_final <- rpart(diagnosis ~ .,
                    data    = training,
                    method  = "class",
                    control = rpart.control(minsplit  = grid$minsplit[best],
                                            minbucket = grid$minbucket[best],
                                            maxdepth  = grid$maxdepth[best],
                                            cp        = grid$cp[best]))
prp(tree_final, type = 2, extra = 104, box.palette = "GnRd")

pred_final <- predict(tree_final, newdata = testing, type = "class")
table(Actual = testing$diagnosis, Predicted = pred_final)

# Default tree vs tuned tree on the same test set
round(rbind(default = evaluate(pred_default, testing$diagnosis),
            tuned   = evaluate(pred_final,   testing$diagnosis)), 3)

# With seed 1 both trees reach roughly 91-93 % accuracy on the test set and the
# tuned tree is not better. The test set has only 114 tumours, so one or two
# predictions move the score by about 1-2 percentage points. The cross-validated
# accuracy (~94 %) is averaged over 5 folds and is a more stable estimate.
# Lesson: tuning does not always win, and a single small test set is noisy.
