# Implementation of the factorial function using recursion

# Pablo Banzo Prida
# 2023-04-17

# Factorial module. All modules start with a capital letter (scope is do - end)
defmodule Factorial do
  # Create a function. All functions start with lowercase
  def fact(n) do
    if n == 0 do
      1
    else
      # return the last line of the function
      n * fact(n - 1)
    end
  end

  # Helper fn for tail recursion
  # defp for private fn
  # defp do_fact_tail(n, r) do
  #   if n == 0 do
  #     r
  #   else
  #     do_fact_tail(n - 1, n * r)
  #   end
  # end

  # Using pattern matching
  # Using a guard (when) to check the value of r
  defp do_fact_tail(0, r) when r < 1, do: r
  defp do_fact_tail(n, r), do: do_fact_tail(n - 1, n * r)

  # Tail recursion version
  # def fact_tail(n) do
  #   do_fact_tail(n, 1)
  # end

  # Using pattern matching
  def fact_tail(n), do: do_fact_tail(n, 1)
end

# Fibonacci module (using pattern matching)
# Pattern matching is a way to reduce the number of if statements
defmodule Fibonacci do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)
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
IO.puts(Factorial.fact(-1))
IO.puts(Factorial.fact_tail(5))
IO.puts(Fibonacci.fib(1))
