# Using tasks to launch several processes at once

defmodule Concur do
  def test_function(id) do
    IO.puts("Hello from #{id}")
  end

  def main() do
    IO.puts("Starting main")
    # Create new process
    id1 = Task.async(fn -> test_function("One") end)
    id2 = Task.async(fn -> test_function("Two") end)
    id3 = Task.async(fn -> test_function("Three") end)
    # Wait for processes to finish
    Task.await(id1)
    Task.await(id2)
    Task.await(id3)
    # Main does not continue until all processes are finished
    IO.puts("Main thread FINISHED")
  end

  def main2() do
    IO.puts("Starting main")
    # Create new process
    ["One", "Two", "Three", "Four"] # List of arguments to pass to test_function
    # Returns a list of tasks
    |> Enum.map(&Task.async(fn -> test_function(&1) end))
    |> IO.inspect()
    # Wait for processes to finish
    |> Enum.map(&Task.await(&1))
    |> IO.inspect()

    # Main does not continue until all processes are finished
    IO.puts("Main thread FINISHED")
  end
end

Concur.main2()
