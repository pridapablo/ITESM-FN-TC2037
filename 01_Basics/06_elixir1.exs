# Implementation of the factorial function using recursion

# Pablo Banzo Prida
# 2023-04-17

# Factorial module. All modules start with a capital letter (scope is do - end)
defmodule Factorial do
  # Create a function. All functions start with lowercase
  # def fact(n) do
  #   if n == 0 do
  #     1
  #   else
  #     # return the last line of the function
  #     n * fact(n - 1)
  #   end
  # end

  # Helper fn for tail recursion
  # defp for private fn
  # defp do_fact_tail(n, r) do
  #   if n == 0 do
  #     r
  #   else
  #     do_fact_tail(n - 1, n * r)
  #   end
  # end

  # Regular recursion version (using pattern matching)
  def fact(n) when n < 0, do: {:error, :negative_number}
  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)

  # Using pattern matching
  # Using a guard (when) to check the value of r
  defp do_fact_tail(0, r) when r < 1, do: r
  defp do_fact_tail(n, r), do: do_fact_tail(n - 1, n * r)

  # Tail recursion version
  # def fact_tail(n) do
  #   do_fact_tail(n, 1)
  # end

  # Using pattern matching
  def fact_tail(n) when n < 0, do: {:error, :negative_number}
  def fact_tail(0), do: 1
  def fact_tail(n), do: do_fact_tail(n, 1)
end

# Fibonacci module (using pattern matching)
# Pattern matching is a way to reduce the number of if statements
defmodule Fibonacci do
  # def fib(n) when n < 0, do: :error
  # Not a good solution because return type is not the same
  def fib(n) when n < 0, do: {:error, :negative_number}
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)

  # fibo tail recursion with pattern matching
  def fib_tail(n) when n < 0, do: {:error, :negative_number}
  def fib_tail(0), do: 0
  def fib_tail(1), do: 1
  def fib_tail(n), do: do_fib_tail(0, 1, n - 1)

  # Helper fn for tail recursion (private)
  defp do_fib_tail(_a, b, 0), do: b
  defp do_fib_tail(a, b, n), do: do_fib_tail(b, a + b, n - 1)
end

# Others
defmodule Others do
  def test(a, b) do
    c = a * b
    # like switch (macro)
    cond do
      c > 0 -> "good"
      c < -10 -> "ok"
    end
  end
end

# Call the functions
IO.puts(Factorial.fact(5))
IO.puts(Factorial.fact(0))
# IO.puts(Factorial.fact(-1))
IO.puts(Factorial.fact_tail(5))
IO.puts(Fibonacci.fib(1))
IO.puts(Fibonacci.fib(-10))
IO.puts(Fibonacci.fib_tail(1))
IO.puts(Fibonacci.fib_tail(-10))
