# ==============================================================================
# 03 - Vectors and data frames
# ------------------------------------------------------------------------------
# Data   : data/titanic.csv
# Topics : c(), indexing, which(), adding / removing elements,
#          building data frames, cbind() / rbind(), seq() and rep()
# ==============================================================================

titanic <- read.csv("data/titanic.csv", header = TRUE, sep = ",", dec = ".")

# ---- Vectors ------------------------------------------------------------------
# A vector is one-dimensional and every element has the same data type.
# c() means "combine".
first_vector <- c(3, 6, 7)
first_vector[1]
first_vector[2]
first_vector[3]

# A column of a data frame is a vector
names_vector <- titanic$Name
is.vector(names_vector)
names_vector[123]                  # name of the passenger in row 123

# Find the position of a value
which(first_vector == 6)

# Replace a value at a given position
first_vector[1] <- -10
first_vector

# Add values at the end
first_vector <- c(first_vector, 9)
first_vector <- c(first_vector, c(7, 8, 9))
first_vector

# Delete the value at a given position (negative index)
first_vector <- first_vector[-2]
first_vector

length(first_vector)               # number of elements
max(first_vector)
min(first_vector)

# ---- Using which() on the Titanic data ----------------------------------------
# Who paid the most? Two equivalent ways:
ind <- which(titanic$Fare == max(titanic$Fare))
titanic$Name[ind]
titanic$Name[titanic$Fare == max(titanic$Fare)]

# Who was the oldest?
pos <- which(titanic$Age == max(titanic$Age))
titanic$Name[pos]

# ---- Data frames: two dimensions [row, column] -------------------------------
titanic[3, 4]          # row 3, column 4
titanic[3, ]           # all of row 3 (do not forget the comma)
head(titanic[, 4])     # all of column 4
head(titanic$Sex)      # same column by name (preferred)

# All information about the oldest passenger
titanic[pos, ]

# ---- Building a data frame from scratch ---------------------------------------
people <- data.frame(
  Name = c("Alvaro", "Alicia", "Ruben"),
  Age  = c(23, 45, 50)
)
people

# Add new variables (columns) with cbind()
people <- cbind(people, City   = c("Madrid", "Barcelona", "Almeria"))
people <- cbind(people, Salary = c(1000, 2000, 3000))
str(people)

# Add a new observation (row) with rbind()
people <- rbind(people,
                data.frame(Name = "Maria", Age = 22, City = "Seville", Salary = 3000))
people

# Remove a variable by setting it to NULL
people$Name <- NULL

# Remove an observation with a negative row index
people <- people[-1, ]
people

# ---- seq() and rep() ----------------------------------------------------------
# seq() creates sequences
seq(from = 10, to = 100, by = 3)

# All odd numbers below 300, and how many there are
odd_numbers <- seq(from = 1, to = 299, by = 2)
length(odd_numbers)                # 150

# rep() repeats a value; handy for initialising a vector before a loop
rep(0, times = 10)
