# ==============================================================================
# Practice - Spot the error (exercises 1-32)
# ------------------------------------------------------------------------------
# Each exercise started as a short snippet with a bug. For every one:
#   Bug  - the broken code and what R said
#   Fix  - why it fails, followed by the corrected code
# ==============================================================================

library(ggplot2)

# ---- Vectors ------------------------------------------------------------------

# Ex 1. Bug: c(1 2, 3, 4)  -> "unexpected numeric constant"
#       Fix: elements inside c() are separated by commas.
my_vec <- c(1, 2, 3, 4)

# Ex 2. Bug: my_vec[0] returns numeric(0) instead of 10
#       Fix: R indexes from 1, not 0.
my_vec <- c(10, 20, 30)
my_vec[1]

# Ex 3. Bug: my_vec = 10, 20, 30  -> "unexpected ','"
#       Fix: several values must be combined with c().
my_vec <- c(10, 20, 30)

# Ex 4. Bug: my_vec[1, 2]  -> "incorrect number of dimensions"
#       Fix: a vector has one dimension; pass the positions as one vector.
my_vec <- c(5, 10, 15)
my_vec[c(1, 2)]

# Ex 5. Bug: log(words)  -> "non-numeric argument to mathematical function"
#       Fix: log() only works on numbers; text can just be printed.
words <- c("Hello", "World")
print(words)

# ---- Data frames and read.csv -------------------------------------------------
# (data_file.csv does not exist in this repo, so Ex 6-7 are shown as comments.)

# Ex 6. Bug: read.csv(data_file.csv)  -> "object 'data_file.csv' not found"
#       Fix: a file name is text and needs quotes.
# my_data <- read.csv("data_file.csv")

# Ex 7. Bug: header = True  -> "object 'True' not found"
#       Fix: logical values are written TRUE / FALSE in capitals.
# my_data <- read.csv("data_file.csv", header = TRUE)

# Ex 8. Bug: df[1 2]  -> "unexpected numeric constant"
#       Fix: to select rows use [rows, ] and combine the numbers with c().
df <- data.frame(age = c(20, 25), height = c(170, 180))
df[c(1, 2), ]

# Ex 9. Bug: df[age]  -> "object 'age' not found"
#       Fix: column names are text and need quotes.
df["age"]

# Ex 10. Bug: df$age returns NULL
#        Fix: R is case sensitive, the column is called Age.
df <- data.frame(Age = c(20, 25), Height = c(170, 180))
df$Age

# ---- Logical values and logic -------------------------------------------------

# Ex 11. Bug: val = 20 replaced the whole vector
#        Fix: = assigns, == compares. which() returns the matching positions.
val <- c(10, 20, 30)
which(val == 20)

# Ex 12. Bug: is_valid = False  -> "object 'False' not found"
#        Fix: write FALSE in capitals.
is_valid <- FALSE

# Ex 13. Bug: x > 5 and x < 15  -> "unexpected 'and'"
#        Fix: R uses & for AND.
x <- 10
x > 5 & x < 15

# Ex 14. Bug: x == 5 or x == 10  -> "unexpected 'or'"
#        Fix: R uses | for OR.
x == 5 | x == 10

# Ex 15. Bug: my_val == hi  -> "object 'hi' not found"
#        Fix: text must be in quotes.
my_val <- "hi"
my_val == "hi"

# ---- for loops ----------------------------------------------------------------

# Ex 16. Bug: for i in 1:5 { ... }  -> "unexpected symbol"
#        Fix: the loop header needs parentheses.
for (i in 1:5) {
  print(i)
}

# Ex 17. Bug: the console shows "+" and waits
#        Fix: the closing } was missing.
for (i in 1:3) {
  print(exp(i))
}

# Ex 18. Bug: print(i * 10) only ran once, after the loop
#        Fix: without { } only the first line belongs to the loop.
for (i in 1:2) {
  print(i)
  print(i * 10)
}

# Ex 19. Bug: prints NA NA NA
#        Fix: i already IS the value (10, 20, 30), not a position.
#             my_numbers[10] does not exist, hence NA.
my_numbers <- c(10, 20, 30)
for (i in my_numbers) {
  print(i)
}

# Ex 20. Bug: "object 'total' not found"
#        Fix: Total and total are different names (case sensitive).
total <- 0
for (i in 1:5) {
  total <- total + i
}
total

# ---- Basic functions ----------------------------------------------------------

# Ex 21. Bug: log(-10) gives NaN and a warning
#        Fix: the logarithm is only defined for positive numbers.
log(10)

# Ex 22. Bug: sin(90) returned 0.894 instead of 1
#        Fix: R's trigonometric functions use radians, so convert degrees.
sin(90 * pi / 180)

# ---- ggplot2 ------------------------------------------------------------------

# Ex 23. Bug: ggplot(...) %>% geom_point()  -> "mapping must be created by aes()"
#        Fix: ggplot layers are added with +, not the pipe %>%.
df <- data.frame(age = c(20, 25, 30), weight = c(60, 70, 80))
ggplot(data = df, aes(x = age, y = weight)) +
  geom_point()

# Ex 24. Bug: ggplot(data = df, x = age, y = weight) gives blank axes
#        Fix: variables must be mapped inside aes().
ggplot(data = df, aes(x = age, y = weight)) +
  geom_point()

# Ex 25. Bug: color = "blue" inside aes() creates a legend called "blue"
#        Fix: fixed colours go in the geom, outside aes().
df <- data.frame(group = c("A", "A", "B", "B"), value = c(10, 15, 20, 25))
ggplot(data = df, aes(x = group, y = value)) +
  geom_boxplot(fill = "red", colour = "blue")

# ---- More vector exercises ----------------------------------------------------

# Ex 26. Bug: values[0] did not return the first value
#        Fix: R starts at index 1.
values <- c(10, 20, 30, 40)
values[1]

# Ex 27. Bug: ages[1, 3] did not return the 1st and 3rd elements
#        Fix: combine the positions with c().
ages <- c(25, 30, 35, 40)
ages[c(1, 3)]

# Ex 28. Bug: data[data = 2] did not find the 2s
#        Fix: comparison uses ==.
data <- c(2, 4, 2, 8)
data[data == 2]

# Ex 29. Bug: && only looks at one value, not the whole vector
#        Fix: use & for element-wise AND.
vec <- c(5, 15, 25, 12)
vec[vec > 10 & vec < 20]

# Ex 30. Bug: nums[c(-1, 2)] mixes negative and positive indices
#        Fix: use only negative indices to drop elements.
nums <- c(10, 20, 30, 40)
nums[-1]

# Ex 31. Bug: seq(from = 10, to = 1, by = 1) -> "wrong sign in 'by'"
#        Fix: counting down needs a negative step.
seq(from = 10, to = 1, by = -1)

# Ex 32. Bug: rep(vals, times = 2) gives 1 2 3 1 2 3
#        Fix: each = 2 repeats every element in place: 1 1 2 2 3 3.
vals <- c(1, 2, 3)
rep(vals, each = 2)
