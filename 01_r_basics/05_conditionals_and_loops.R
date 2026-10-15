# ==============================================================================
# 05 - Conditionals and loops
# ------------------------------------------------------------------------------
# Topics : if / else if / else, for loops, timing code with tictoc,
#          vectorised code vs loops, factorial with input checks
# Needs  : install.packages("tictoc")
# ==============================================================================

library(tictoc)

# ---- if / else ----------------------------------------------------------------
x <- 10
if (x > 0) {
  print(paste("The value", x, "is positive"))
}

x <- -10
if (x > 0) {
  print(paste("The value", x, "is positive"))
} else {                       # `else` must be on the same line as the `}`
  print(paste("The value", x, "is NOT positive"))
}

x <- 0
if (x > 0) {
  print(paste("The value", x, "is positive"))
} else if (x < 0) {
  print(paste("The value", x, "is negative"))
} else {
  print(paste("The value", x, "is neither positive nor negative"))
}

# ---- Odd or even? -------------------------------------------------------------
# A number is even when the remainder of dividing by 2 is 0.
number <- 11
if (number == 0) {
  print("The value 0 is neither odd nor even here")
} else if (number %% 2 == 0) {
  print(paste("The value", number, "is even"))
} else {
  print(paste("The value", number, "is odd"))
}

# ---- Is it an integer? --------------------------------------------------------
# x %% 1 is the decimal part, so it is 0 only for whole numbers.
7 %% 1
7.3 %% 1

n <- 10.7
if (n %% 1 == 0) {
  print(paste("The value", n, "is an integer"))
} else {
  print(paste("The value", n, "is NOT an integer"))
}

# ---- for loops ----------------------------------------------------------------
for (i in 1:6) {
  print("please be quiet")
}

for (i in 1:6) {
  print(i)
}

# ---- Loop or no loop? ---------------------------------------------------------
# Rule from class: only use a loop when it is strictly necessary.
# Task: a vector with the multiples of 2 below 100.

# Vectorised: one line, fast
tic("seq()")
evens <- seq(from = 2, to = 98, by = 2)
toc()

# Loop: grows the vector one element at a time, which is slow in R
tic("for loop")
evens_loop <- c()
for (i in 1:49) {
  evens_loop <- c(evens_loop, 2 * i)
}
toc()

identical(evens, evens_loop)   # same result

# ---- Factorial ----------------------------------------------------------------
# n! = 1 * 2 * ... * n, and 0! = 1.
# Only defined for non-negative integers, so check the input first.
n <- 5
if (n < 0) {
  print("Cannot calculate the factorial: the number is negative")
} else if (n %% 1 != 0) {
  print("Cannot calculate the factorial: the number is not an integer")
} else if (n == 0) {
  print("The factorial of 0 is 1")
} else {
  fact <- 1
  for (i in 1:n) {
    fact <- fact * i
  }
  print(paste0(n, "! = ", fact))
}

factorial(5)   # built-in function to check the answer
