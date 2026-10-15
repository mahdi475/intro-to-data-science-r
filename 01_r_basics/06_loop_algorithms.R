# ==============================================================================
# 06 - Classic algorithms with loops
# ------------------------------------------------------------------------------
# Topics : Fibonacci sequence, square root by iteration (Babylonian method),
#          Maclaurin series for e^x, Sieve of Eratosthenes
# ==============================================================================

# ---- 1. Fibonacci -------------------------------------------------------------
# Each number is the sum of the two before it: 1, 1, 2, 3, 5, 8, 13, ...
n   <- 20
fib <- rep(0, times = n)   # initialise the vector before the loop
fib[1] <- 1
fib[2] <- 1

for (i in 3:n) {
  fib[i] <- fib[i - 1] + fib[i - 2]
}
fib
# (Some definitions start the sequence at 0, 1 instead: then fib[1] <- 0.)

# ---- 2. Square root of 2 by iteration -----------------------------------------
# Babylonian method: a[n+1] = 1/2 * (a[n] + 2 / a[n]) converges to sqrt(2).
a <- 1                     # starting guess
for (i in 1:10) {
  a <- 0.5 * (a + 2 / a)
  print(a)
}
a - sqrt(2)                # the error is (practically) zero

# ---- 3. Maclaurin series for e^x ----------------------------------------------
# e^x = sum over n of x^n / n!
x      <- 3
N      <- 18
approx <- 0

for (k in 0:N) {
  approx <- approx + x^k / factorial(k)
}
approx
exp(x)                     # R's own value, for comparison

# ---- 4. Sieve of Eratosthenes: all primes up to 100 --------------------------
# Start by assuming every number is prime, then cross out the multiples
# of each prime. Checking divisors up to sqrt(n) is enough.
n        <- 100
is_prime <- rep(TRUE, n)
is_prime[1] <- FALSE       # 1 is not a prime

for (i in 2:floor(sqrt(n))) {
  if (is_prime[i]) {
    multiples <- seq(from = 2 * i, to = n, by = i)
    is_prime[multiples] <- FALSE
  }
}

primes <- which(is_prime)
primes
length(primes)             # 25 primes below 100
