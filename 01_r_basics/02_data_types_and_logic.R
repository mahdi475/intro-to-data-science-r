# ==============================================================================
# 02 - Data types and logical operations
# ------------------------------------------------------------------------------
# Data   : data/titanic.csv
# Topics : integer / numeric / logical types, the %% operator,
#          logical comparisons, counting with sum(), AND (&) and OR (|)
# ==============================================================================

titanic <- read.csv("data/titanic.csv", header = TRUE, sep = ",", dec = ".")
str(titanic)   # str = structure (not string)

# ---- Data types ---------------------------------------------------------------
# Integer: whole numbers, often used as counters in loops
integer1 <- 9L
class(integer1)
integer1 + 7L
integer1 / 3    # dividing returns a numeric, not an integer

11 %% 4         # %% is the modulo operator (remainder of a division)
9 %% 2

# Numeric: real numbers (float / double in other languages)
n1 <- 7.3
n2 <- 8.1
n1 + n2
exp(n1)

# Logical: TRUE / FALSE, created by comparisons  <  <=  ==  >=  >
7 > 1.1
8 < 7
2 == 2

# ---- Asking questions with logical vectors ------------------------------------
# `$` accesses one variable (column) of a data frame.
# A comparison returns one TRUE/FALSE per row, and sum() counts the TRUEs.

# Q1. How many people travelled in first class?
sum(titanic$Pclass == 1)                          # 216

# Q2. What percentage of the passengers travelled in first class?
sum(titanic$Pclass == 1) / nrow(titanic) * 100    # ~24.4 %

# Q3. How many people paid more than 10 for their ticket?
sum(titanic$Fare > 10)                            # 554

# Q4. Percentage of males and females.
#     Text must be compared in quotes ("male"), otherwise R looks for a variable.
sum(titanic$Sex == "male")   / nrow(titanic) * 100   # ~64.6 %
sum(titanic$Sex == "female") / nrow(titanic) * 100   # ~35.4 %

# ---- Indexing -----------------------------------------------------------------
# [] indexes vectors and data frames, () calls functions.
# R starts counting at 1 (Python and C start at 0).
titanic$Name[100]

# Q5. What is the name of the oldest person/people?
oldest_age <- max(titanic$Age)
titanic$Name[titanic$Age == oldest_age]

# Q6. Who paid the highest fare?
highest_fare <- max(titanic$Fare)
top_payers   <- titanic$Name[titanic$Fare == highest_fare]
top_payers

# Q7. Did those people survive?
titanic$Survived[titanic$Fare == highest_fare]    # yes, all three

# ---- AND (&) and OR (|) -------------------------------------------------------
# &  is TRUE only if both sides are TRUE
TRUE  & TRUE
TRUE  & FALSE
FALSE & FALSE

# |  is TRUE if at least one side is TRUE
TRUE  | TRUE
TRUE  | FALSE
FALSE | FALSE

# Q8. How many passengers were female AND older than 18?
sum(titanic$Sex == "female" & titanic$Age > 18)   # 234

# Q9. Survival rate (%) in each passenger class
first  <- sum(titanic$Survived == 1 & titanic$Pclass == 1) / sum(titanic$Pclass == 1) * 100
second <- sum(titanic$Survived == 1 & titanic$Pclass == 2) / sum(titanic$Pclass == 2) * 100
third  <- sum(titanic$Survived == 1 & titanic$Pclass == 3) / sum(titanic$Pclass == 3) * 100
c(first = first, second = second, third = third)  # ~63 %, ~47 %, ~24 %

# Q10. Did a higher share of females or males survive?
female_rate <- sum(titanic$Survived == 1 & titanic$Sex == "female") / sum(titanic$Sex == "female") * 100
male_rate   <- sum(titanic$Survived == 1 & titanic$Sex == "male")   / sum(titanic$Sex == "male")   * 100
c(female = female_rate, male = male_rate)         # ~74 % vs ~19 %
