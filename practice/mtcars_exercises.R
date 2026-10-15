# ==============================================================================
# Practice - Reading, inspecting and filtering data (exercises 141-162)
# ------------------------------------------------------------------------------
# Data   : data/mtcars.csv - 32 cars from the 1974 Motor Trend magazine
#   mpg  miles per gallon            cyl   number of cylinders
#   disp displacement (cu.in.)       hp    gross horsepower
#   drat rear axle ratio             wt    weight (1000 lbs)
#   qsec 1/4 mile time (seconds)     vs    engine shape (0 = V, 1 = straight)
#   am   transmission (0 = automatic, 1 = manual)
#   gear forward gears               carb  number of carburetors
# ==============================================================================

# ---- Part 1: reading and inspecting -------------------------------------------

# 141. Read mtcars.csv into a data frame called cars_data
cars_data <- read.csv("data/mtcars.csv", header = TRUE, sep = ",", dec = ".")

# 142. Read it again so that text columns (car_model) become factors
cars_data <- read.csv("data/mtcars.csv", header = TRUE, sep = ",", dec = ".",
                      stringsAsFactors = TRUE)

# 143. First 6 rows
head(cars_data, 6)

# 144. Last 5 rows
tail(cars_data, 5)

# 145. Dimensions (rows, columns)
dim(cars_data)

# 146. Structure and data types
str(cars_data)

# 147. Column names
names(cars_data)

# 148. Summary statistics for every variable
summary(cars_data)

# 149. The mpg column as a vector
cars_data$mpg

# 150. Rows 1 to 10
cars_data[1:10, ]

# 151. The value in row 4, column 2
cars_data[4, 2]

# ---- Filtering ----------------------------------------------------------------

# 152. Cars with more than 200 hp
cars_data[cars_data$hp > 200, ]

# 153. Cars with exactly 8 cylinders
cars_data[cars_data$cyl == 8, ]

# 154. Efficient small cars: 4 cylinders AND more than 25 mpg
cars_data[cars_data$cyl == 4 & cars_data$mpg > 25, ]

# 155. Only the columns car_model, mpg and hp
cars_data[, c("car_model", "mpg", "hp")]

# 156. Cars with 4 OR 6 cylinders
cars_data[cars_data$cyl == 4 | cars_data$cyl == 6, ]

# 157. Cars with manual transmission
cars_data[cars_data$am == 1, ]

# 158. Rows 12 to 20, first four columns
cars_data[12:20, 1:4]

# ---- Summary statistics -------------------------------------------------------

# 159. Mean fuel economy
mean(cars_data$mpg)

# 160. Median weight
median(cars_data$wt)

# 161. Maximum horsepower
max(cars_data$hp)

# 162. Fastest quarter-mile time
min(cars_data$qsec)
