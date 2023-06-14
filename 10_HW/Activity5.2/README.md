# Parallel and Sequential Programming

## Activity: 5.2 - Analysis of the performance of a parallel program

### By:

- **Gabriel Rodriguez De Los Reyes**
- **Pablo Banzo Prida**

The goal of this activity is to compare the performance of a sequential and a
parallel program that computes the sum of all prime numbers up to a given
number.

We compute the sum of all prime numbers up to 5,000,000 with both the sequential
version of the function `sum_primes` and the parallel version of the same
function `sum_primes_parallel`.

First, we made sure that both functions return the same result for the sum of
primes with different values for the number of threads:

```elixir
iex(1)> Hw.sum_primes(5_000_000)
838596693108
iex(2)> Hw.sum_primes_parallel(5_000_000, 8)
838596693108
iex(3)> Hw.sum_primes_parallel(5_000_000, 4)
838596693108
iex(4)> Hw.sum_primes_parallel(5_000_000, 2)
838596693108
```

# Time analysis

The following table shows the results of the execution of the program with the
two different versions of the function. Considering that the computer may be
running other processes at the same time, we run the program 3 times and take
the average of the results.

We ran the following script in a for loop for each function:

## **Parallel**

```elixir
Timing.time_execution(fn ->
  IO.inspect(Hw.sum_primes_parallel(5_000_000, 8), label: "Parallel sum result X")
end)
```

### **Parallel Results**

```
Parallel sum result 1: 838596693108
Time in seconds: 0.64019
Parallel sum result 2: 838596693108
Time in seconds: 0.626209
Parallel sum result 3: 838596693108
Time in seconds: 0.654678
```

## **Sequential**

```elixir
Timing.time_execution(fn ->
  IO.inspect(Hw.sum_primes(5_000_000), label: "Sequential sum result X")
end)
```

### **Sequential Results**

```
Sequential sum result 1: 838596693108
Time in seconds: 2.586136
Sequential sum result 2: 838596693108
Time in seconds: 2.583493
Sequential sum result 3: 838596693108
Time in seconds: 2.578344
```

## **Analysis**

Given the results, we can see that the parallel version of the function is
faster than the sequential version in all runs. It is also worth noting that the
computer running the tests has 8 cores (MacBook Air M2 512GB SSD 24GB RAM), so
the parallel version of the function is able to take advantage of all the cores
when running `Hw.sum_primes_parallel(5_000_000, 8)`.

# Speedup analysis

$$ \begin{equation} S_p = \frac{T_s}{T_p} \end{equation} $$

Where:

- $S_p$ is the speedup
- $T_s$ is the time of the sequential version of the function
- $T_p$ is the time of the parallel version of the function

## **Speedup**

$$ \begin{equation} S_p = \frac{2.5826576667}{0.640359} = 4.0331402646
\end{equation} $$

## Conclusion

The speedup of the parallel version of the function is 4.0331402646, which means
that the parallel version of the function is 4 times faster than the sequential
version of the function.
