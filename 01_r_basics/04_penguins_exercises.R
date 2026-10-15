# ==============================================================================
# 04 - Exercises: penguins, vectors and data frames
# ------------------------------------------------------------------------------
# Data   : data/penguins.csv (Palmer Penguins, 333 penguins, no missing values)
# Topics : factors, table(), filtering rows, which(), means by group,
#          building and editing a data frame
# ==============================================================================

rm(list = ls())

readLines("data/penguins.csv", n = 2)

# Q1. Load the data with stringsAsFactors = TRUE so that text columns become
#     factors, then count observations (rows) and variables (columns).
penguins <- read.csv("data/penguins.csv",
                     header = TRUE,
                     sep    = ",",
                     dec    = ".",
                     stringsAsFactors = TRUE)
nrow(penguins)
ncol(penguins)

# Q2. Which variables are integer, factor, numeric and logical?
str(penguins)

# Q3. Frequency table of island. Where were the most penguins recorded?
table(penguins$island)                             # Biscoe

# Q4. How many observations were collected in 2007? Three ways:
table(penguins$year)
sum(penguins$year == 2007)
length(which(penguins$year == 2007))

# Q5. Maximum bill length, how many penguins have it, and their full rows
max_bill <- max(penguins$bill_length_mm)
max_bill
sum(penguins$bill_length_mm == max_bill)
penguins[penguins$bill_length_mm == max_bill, ]

# Q6. Mean bill length per species
mean(penguins$bill_length_mm[penguins$species == "Adelie"])
mean(penguins$bill_length_mm[penguins$species == "Chinstrap"])
mean(penguins$bill_length_mm[penguins$species == "Gentoo"])
# Adelie has clearly shorter bills (~38.8 mm) than Chinstrap and Gentoo (~48 mm)

# Q7. Number of male and female Adelie penguins and their mean bill length
sum(penguins$species == "Adelie" & penguins$sex == "male")
sum(penguins$species == "Adelie" & penguins$sex == "female")

adelie_males   <- penguins[penguins$species == "Adelie" & penguins$sex == "male", ]
adelie_females <- penguins[penguins$species == "Adelie" & penguins$sex == "female", ]
mean(adelie_males$bill_length_mm)
mean(adelie_females$bill_length_mm)

# Q8. How many penguins weigh more than 5000 g?
sum(penguins$body_mass_g > 5000)

# Q9. How many penguins have a bill longer than 50 mm?
sum(penguins$bill_length_mm > 50)

# Q10. How many male penguins live on Biscoe?
sum(penguins$sex == "male" & penguins$island == "Biscoe")

# Q11. All information about the heaviest penguin(s)
penguins[penguins$body_mass_g == max(penguins$body_mass_g), ]

# ---- Vectors ------------------------------------------------------------------
# Q12. Create a vector
numbers <- c(1, 3, 4, 5)

# Q13. Append 7, 8 and 9
numbers <- c(numbers, 7, 8, 9)
numbers

# Q14. Number of elements
length(numbers)

# Q15. First element
numbers[1]

# Q16. Sequence 2, 4, 6
seq(from = 2, to = 6, by = 2)

# Q17. Positions of the even numbers greater than 3
which(numbers %% 2 == 0 & numbers > 3)

# Q18 - Q19. Positions and values of the numbers greater than 5
which(numbers > 5)
numbers[numbers > 5]

# Q20 - Q21. Logical test "> 4" and the values that pass it
numbers > 4
numbers[numbers > 4]

# Q22. Replace the 5 with a 6
numbers[numbers == 5] <- 6
numbers

# Q23. Position of the maximum value
which(numbers == max(numbers))

# Q24. How many numbers are greater than 3?
sum(numbers > 3)

# ---- Data frames --------------------------------------------------------------
# Q25. Create a customers data frame
customers <- data.frame(
  Name     = c("Ana", "Carlos", "Laura"),
  Age      = c(25, 34, 29),
  City     = c("Madrid", "Valencia", "Madrid"),
  Spending = c(1200, 850, 1500)
)
customers

# Q26 - Q27. Rows and columns
nrow(customers)
ncol(customers)

# Q28. The Name column
customers$Name

# Q29. The first row
customers[1, ]

# Q30. The first two rows
customers[1:2, ]

# Q31. Only Name and City
customers[, c("Name", "City")]

# Q32 - Q33. Add two new customers
customers <- rbind(customers, data.frame(Name = "Pablo", Age = 41, City = "Barcelona", Spending = 2000))
customers <- rbind(customers, data.frame(Name = "Marta", Age = 31, City = "Madrid",    Spending = 950))
customers

# Q34. Add a customer type column
customers <- cbind(customers,
                   Customer_type = c("Premium", "Standard", "Premium", "Standard", "Premium"))

# Q35 - Q37. Filters
customers[customers$City == "Madrid", ]
customers[customers$Spending > 1000, ]
customers[customers$Age > 30, ]

# Q38 - Q39. Highest and lowest spender
customers[customers$Spending == max(customers$Spending), ]
customers[customers$Spending == min(customers$Spending), ]

# Q40 - Q41. Mean and total spending
mean(customers$Spending)
sum(customers$Spending)

# Q42. Logical column: did the customer spend more than 1000?
customers$High_value <- customers$Spending > 1000

# Q43. Carlos moved to Barcelona
customers$City[customers$Name == "Carlos"] <- "Barcelona"

# Q44. Laura's spending is now 1800
customers$Spending[customers$Name == "Laura"] <- 1800
customers

# Q45. Customers in Madrid who spent more than 1000
customers[customers$City == "Madrid" & customers$Spending > 1000, ]

# Q46. Add myself, then show customers from Madrid OR Barcelona
customers <- rbind(customers,
                   data.frame(Name = "Mahdi", Age = 21, City = "Gothenburg", Spending = 2000,
                              Customer_type = "Premium", High_value = TRUE))
customers[customers$City == "Madrid" | customers$City == "Barcelona", ]
