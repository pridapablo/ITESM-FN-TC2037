# Functions to work with lists Designed by professor Ariel Ortiz (CEM)
#
# Gilberto Echeverria 2023_04_24

# Comments shouldn't be longer than 80 characters

defmodule Hw.Ariel2 do
  @doc """
  1. The `insert` function takes two inputs: a number `n` and a list `lst` that contains numbers in
  ascending order. Returns a new list with the same elements of `lst` but with `n` inserted in its
  corresponding place.
  """
  def insert(list, item),
    do: do_insert(list, item, [])

  # base case
  defp do_insert([], item, temp),
    # append the item to the end of the list
    do: Enum.reverse(temp) ++ [item]

  # i've found where to insert the item
  defp do_insert([head | tail], item, temp) when item < head,
    # pipe expects an item | list
    do: Enum.reverse(temp) ++ [item, head | tail]

  defp do_insert([head | tail], item, temp),
    do: do_insert(tail, item, [head | temp])

  # @doc """
  # 2. The `insertion_sort` function takes an unsorted list of numbers as input and returns a new
  # list with the same elements but in ascending order. The `insert` function defined in the
  # previous exercise should be used to write `insertion_sort`. The `sort` or any similar predefined
  # function should not be used. """

  @doc """
  !!!!3. The `rotate_left` function takes two inputs: an integer `n` and a list `lst`. Returns the
  list that results from rotating `lst` a total of `n` elements to the left. If `n` is negative,
  rotates to the right.
  """

  def rotate_left(lst, n),
    do: do_rotate_left(lst, n, [])

  # base case: n is 0, so return the list
  defp do_rotate_left(lst, 0, _temp),
    do: lst

  # empty list case
  defp do_rotate_left([], _n, temp),
    do: Enum.reverse(temp)

  # positive rotation case (left)
  defp do_rotate_left([head | tail], n, temp) when n > 0,
    do: do_rotate_left(tail ++ [head], n - 1, [head | temp])

  # negative rotation case (right)
  defp do_rotate_left(lst, n, _temp) when n < 0,
    # convert the negative rotation to a positive one using the length of the list
    do: do_rotate_left(lst, length(lst) + n, [])

  # adding the length of the list to the negative number of rotations will make it positive

  # @doc """ !!!!4. The `prime_factors` function takes an integer `n` as input (`n` > 0) and returns
  # a list that contains the prime factors of `n` in ascending order. Prime factors are the prime
  # numbers that exactly divide a number. If all the prime factors are multiplied, the original
  # number is obtained. """

  @doc """
  !!!!5. The `gcd` function takes two positive integer inputs `a` and `b`, where `a` > 0 and `b` >
  0. Returns the greatest common divisor (GCD) of `a` and `b`. The `gcd` or similar predefined
  function should not be used. NOTE: The GCD of two integers is the largest positive integer that
  divides both numbers exactly. For example, the GCD of 20 and 16 is 4.
  """

  def gcd(a, b),
    do: do_gcd(a, b)

  # base case: b is 0, so return a (taken from the euclidean algorithm)
  defp do_gcd(a, 0),
    do: a

  # recursive case (while b isn't 0) b is the new a and the remainder of a/b and use it as the new b
  defp do_gcd(a, b),
    # already tail recursive because the last call is the function itself
    do: do_gcd(b, rem(a, b))

  # @doc """ !!!!6. The `deep_reverse` function takes a list as input. Returns a list with the same
  # elements as its input but in reverse order. If there are nested lists, these should also be
  # reversed. """

  # @doc """
  # 7. The `insert_anywhere` function takes two inputs: an object `x` and a list `lst`. Returns a
  #    new list with all the possible ways in which `x` can be inserted in each position of `lst`.
  # """

  # @doc """
  # 8. The `pack` function takes a list `lst` as input. Returns a list of lists that group
  #    consecutive equal elements. """

  # @doc """
  # 9. The `compress` function takes a list `lst` as input. Returns a list in which consecutive
  #    repeating elements of `lst` are replaced by a single instance. The order of the elements
  #    should not be changed. """

  # @doc """
  # 10. The `encode` function takes a list `lst` as input. Consecutive elements in `lst` are encoded
  #     in lists of the form: (n e), where `n` is the number of occurrences of element `e`. """

  # @doc """
  # 11. The `encode_modified` function takes a list `lst` as input. It works the same as the
  #     previous problem, but if an element has no duplicates, it is simply copied to the resulting
  #     list. Only elements that have consecutive repetitions are converted into lists of the form:
  # (n e). """

  # @doc """
  # 12. The `decode` function takes an encoded list `lst` as input, which has the same structure as
  #     the result list of the previous problem. Returns the decoded version of `lst`. """

  # @doc """
  # 13. The `args_swap` function takes a two_argument function `f` as input and returns a new
  # function that behaves like `f` but with the order of its two arguments exchanged. In other
  # words: ((args_swap f) x y) ≡ (f y x) """

  # @doc """
  # 14. The `there_exists_one?` function takes two inputs: a boolean function of one argument `pred`
  #     and a list `lst`. Returns `true` if there is exactly one element in `lst` that satisfies
  #     `pred`, otherwise returns `false`. """

  # @doc """
  # 15. The `linear_search` function takes three inputs: a list `lst`, a value `x`, and an equality
  # function `eq_fun`. Sequentially searches for `x` in `lst` using `eq_fun` to compare `x` with the
  # elements contained in `lst`. The `eq_fun` function should accept two arguments, `a` and `b`, and
  # return `true` if `a` should be considered equal to `b`, or `false` otherwise. The
  # `linear_search` function returns the index where the first occurrence of `x` in `lst` is found
  # (the first element of the list is at index 0), or `false` if it was not found. """

  # @doc """
  # 16. The derivative of a function `f(x)` with respect to the variable `x` is defined as: `f′(x)≡
  # lim_{h_>0} frac f{(x+h)−f(x)}{h}` Where `f` must be a differentiable real function. Write the
  # `deriv` function that takes `f` and `h` as inputs, and returns a new function that takes `x` as
  # argument, and that represents the derivative of `f` given a certain value of `h`. """

  # @doc """
  # 17. The Newton method is an algorithm for finding the root of a function by successively
  # calculating better approximations. It can be summarized as follows: `x_n = x_{n_1} _
  # frac{f(x_{n_1})}{f'(x_{n_1})}` if `n > 0` `x_n = 0` if `n = 0`

  # Some things to note: _ `f` must be a differentiable real function. _ The greater the value of
  # `n`, the better the approximation. _ `x0` is an initial approximation, and it is recommended to
  # be a value close to the solution. This allows the result to be calculated more quickly. However,
  # for simplicity, we always assume here that `x0 = 0`. """

  # @doc """
  # 18. Write the `newton` function that takes `f` and `n` as inputs, and returns the corresponding
  # value of `xn`. Use the `deriv` function from the previous problem to calculate `f′`, with `h =
  # 0.0001`. """
end
