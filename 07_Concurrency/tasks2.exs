# Sum all numbers between 100 and 900 using concurrency
# Depending on how many cores the machine has, we should choose the number of processes to spawn

defmodule Sums do
  # Helper function to sum numbers between two values
  def range_sum({start, stop}) do
    # start..stop is a range which can be converted to an enumerable without using Enum.to_list
    Enum.sum(start..stop)
  end

  def make_ranges(start, finish, cores) do
    [{100, 200}, {201, 300}, {301, 400}, {401, 500}]
  end

  # Function to sum numbers between 1000 and 9000
  def total_sum(start, finish, cores) do
    IO.puts("MAIN THREAD STARTED")

    # Parallelize the sum by splitting the range into 4 parts
    make_ranges(start, finish, cores)
    # Create a task for each range
    |> Enum.map(&Task.async(fn -> range_sum(&1) end))
    # Wait for all tasks to finish
    |> Enum.map(&Task.await(&1))
    |> IO.inspect()
    # Sum the results
    |> Enum.sum()
    |> IO.inspect()

    IO.puts("MAIN THREAD FINISHED")
  end
end

Sums.total_sum(1, 2, 3)
