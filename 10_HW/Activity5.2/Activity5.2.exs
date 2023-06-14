defmodule Hw do
  # Helper function to check if a number is prime A number is prime if it is only divisible by 1 and
  # itself (using pattern matching)
  defp is_prime?(n) when n < 2, do: false
  defp is_prime?(n), do: do_is_prime?(n, 2)
  # n < divisor * divisor is the same as divisor > sqrt(n) (base case)
  defp do_is_prime?(n, divisor) when n < divisor * divisor, do: true
  defp do_is_prime?(n, divisor) when rem(n, divisor) == 0, do: false
  defp do_is_prime?(n, divisor), do: do_is_prime?(n, divisor + 1)

  # Helper function to sum all prime numbers in a given range (called by sum_primes_parallel)
  defp sum_primes_in_range({start, stop}) do
    # Recieve a tuple of the start and stop numbers
    start..stop
    # Filter out all non-prime numbers
    |> Enum.filter(&is_prime?/1)
    |> Enum.sum()
  end

  # Helper function to generate chunks of numbers to be processed by each process (called by
  # sum_primes_parallel)
  defp generate_chunks(limit, num_processes) do
    chunk_size = div(limit, num_processes)

    0..(num_processes - 1)
    |> Enum.map(fn i ->
      # The first two numbers are not prime, so we start at 2
      start = i * chunk_size + 2
      # When we reach the last process, the stop number is the limit Otherwise, the stop number is
      # the start number plus the chunk size
      stop = if i == num_processes - 1, do: limit, else: start + chunk_size - 1
      # Return a tuple of the start and stop numbers
      {start, stop}
    end)
  end

  @doc """
  Sums all prime numbers up to a given number (sequential)

  limit: the number up to which to sum all prime numbers
  """
  def sum_primes(limit) do
    2..limit
    |> Enum.filter(&is_prime?/1)
    |> Enum.sum()
  end

  @doc """
  Sums all prime numbers up to a given number (parallel)

  limit: the number up to which to sum all prime numbers num_processes: the number of processes to
  generate (related to the number of cores on the machine)
  """
  def sum_primes_parallel(limit, num_processes) do
    generate_chunks(limit, num_processes)
    |> Enum.map(&Task.async(fn -> sum_primes_in_range(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.sum()
  end
end

# Helper module to time the execution of a function (for speedup comparison)
defmodule Timing do
  def time_execution(fun) do
    :timer.tc(fun)
    # Get the time in microseconds
    |> elem(0)
    # Convert to seconds
    |> Kernel./(1_000_000)
    |> IO.inspect(label: "Time in seconds")
  end
end
