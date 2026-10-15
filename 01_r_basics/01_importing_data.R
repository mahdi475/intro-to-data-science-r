# ==============================================================================
# 01 - Importing data
# ------------------------------------------------------------------------------
# Data   : data/titanic.csv
# Topics : working directory, peeking at a raw file, read.csv(), str()
# ==============================================================================

# Run a single line in RStudio with Ctrl + Enter.
v1 <- 7 + 4
v1

# ---- Where are my files? ------------------------------------------------------
# R reads files relative to the working directory. Opening the project file
# (intro-to-data-science.Rproj) sets it to the repository root, so every path
# in this repo starts from there.
getwd()             # current working directory
list.files("data")  # files inside the data folder

# ---- Importing a CSV file -----------------------------------------------------
# Before importing a file you need to know three things:
#   sep    - the character that separates the columns
#   header - whether the first line holds the column names
#   dec    - the decimal point
# Looking at the first lines of the raw file answers all three.
readLines("data/titanic.csv", n = 2)

titanic <- read.csv("data/titanic.csv",
                    header = TRUE,
                    sep    = ",",
                    dec    = ".")

# ---- First look at the data ---------------------------------------------------
# R is case sensitive: `titanic` and `Titanic` are different objects.
str(titanic)    # variable names and data types
head(titanic)   # first six rows
dim(titanic)    # rows (passengers) and columns (variables)
