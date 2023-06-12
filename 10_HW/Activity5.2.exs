defmodule Hw do
  # Helper function to check if a number is prime
  # A number is prime if it is only divisible by 1 and itself
  def is_prime?(n) when n < 2, do: false
  def is_prime?(2), do: true
  def is_prime?(3), do: true

  def is_prime?(n) do
    # Only need to check up to sqrt(n)
    divisors = 2..trunc(:math.sqrt(n))
    not divisible_by_any?(n, divisors)
  end

  # Helper function to check if a number is divisible by any of the divisors
  defp divisible_by_any?(num, divisors) do
    divisors
    |> Enum.map(fn divisor -> rem(num, divisor) == 0 end)
    |> Enum.any?()
  end

  # Sums all prime numbers up to a given number (sequential)
  def sum_primes(limit) do
    2..limit
    |> Enum.filter(&is_prime?/1)
    |> Enum.sum()
  end

  # Summation of prime numbers up to a given number (parallel)
  def sum_primes_parallel(limit, num_processes) do
    chunk_size = div(limit, num_processes)
    ranges = Enum.chunk_every(2..limit, chunk_size)

    tasks =
      for range <- ranges do
        Task.async(fn -> Enum.filter(range, &is_prime?/1) |> Enum.sum() end)
      end

    tasks
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sum()
  end
end

defmodule Timing do
  def time_execution(fun) do
    {time, result} = :timer.tc(fun)
    IO.puts("Execution time: #{time} microseconds")
    IO.puts("Result: #{result}")
  end
end

# Sequential
Timing.time_execution(fn -> Hw.sum_primes(13) end)

# Parallel with 2 processes
Timing.time_execution(fn -> Hw.sum_primes_parallel(13, 2) end)

# Parallel with 4 processes
Timing.time_execution(fn -> Hw.sum_primes_parallel(13, 4) end)

IO.puts("is_prime?(2) = #{Hw.is_prime?(2)} should be true")
IO.puts("is_prime?(3) = #{Hw.is_prime?(3)} should be true")
IO.puts("is_prime?(4) = #{Hw.is_prime?(4)} should be false")
IO.puts("is_prime?(5) = #{Hw.is_prime?(5)} should be true")
IO.puts("is_prime?(6) = #{Hw.is_prime?(6)} should be false")
IO.puts("is_prime?(7) = #{Hw.is_prime?(7)} should be true")
IO.puts("is_prime?(8) = #{Hw.is_prime?(8)} should be false")
IO.puts("is_prime?(9) = #{Hw.is_prime?(9)} should be false")
IO.puts("is_prime?(10) = #{Hw.is_prime?(10)} should be false")
IO.puts("is_prime?(11) = #{Hw.is_prime?(11)} should be true")
IO.puts("is_prime?(12) = #{Hw.is_prime?(12)} should be false")
IO.puts("is_prime?(13) = #{Hw.is_prime?(13)} should be true")

IO.puts("sum_primes(10) = #{Hw.sum_primes(10)} should be 17")
IO.puts("sum_primes(100) = #{Hw.sum_primes(100)} should be 1060")
IO.puts("sum_primes(1000) = #{Hw.sum_primes(1000)} should be 76127")

IO.puts("sum_primes_parallel(10, 2) = #{Hw.sum_primes_parallel(10, 2)} should be 17")
IO.puts("sum_primes_parallel(100, 2) = #{Hw.sum_primes_parallel(100, 2)} should be 1060")
IO.puts("sum_primes_parallel(1000, 2) = #{Hw.sum_primes_parallel(1000, 2)} should be 76127")
IO.puts("sum_primes_parallel(1000, 4) = #{Hw.sum_primes_parallel(1000, 4)} should be 76127")
IO.puts("sum_primes_parallel(1000, 8) = #{Hw.sum_primes_parallel(1000, 8)} should be 76127")
IO.puts("sum_primes_parallel(1000, 16) = #{Hw.sum_primes_parallel(1000, 16)} should be 76127")
