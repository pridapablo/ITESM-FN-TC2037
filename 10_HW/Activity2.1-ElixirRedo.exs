# Ex 10 onwards

defmodule Activity do
  @doc """
  10. The positives function takes a list of numbers lst as input and returns a new list containing only the positive numbers of lst.
  """
  def positives(lst), do: do_positives(lst, [])
  # Reverse the list (because we are prepending for performance) this is the base case
  defp do_positives([], res), do: Enum.reverse(res)
  # Keep positive numbers
  defp do_positives([head | tail], res) when head > 0, do: do_positives(tail, [head | res])
  # Discard negative numbers
  defp do_positives([head | tail], res) when head <= 0, do: do_positives(tail, res)

  @doc """
  11. The add-list function returns the sum of the numbers contained in the list passed as input, or 0 if it is empty.
  """
  def add_list(list), do: do_add_list(list, 0)
  # Helper fn for tail recursion if list is empty (base case)
  defp do_add_list([], res), do: res
  # Helper fn for tail recursion if list is not empty (add head to res)
  defp do_add_list([head | tail], res), do: do_add_list(tail, res + head)

  @doc """
  12. The invert-pairs function takes as input a list whose content are two-element tuples (or lists). It returns a new list with each pair inverted.
  """
  def invert_pairs(lst), do: do_invert_pairs(lst, [])
  # Helper fn base case return reversed list
  defp do_invert_pairs([], res), do: Enum.reverse(res)
  # Tail recursion
  # defp do_invert_pairs([head | tail], res), do: do_invert_pairs(tail, [ RECURSIVE CALL | res])
  defp do_invert_pairs([{a, b} | tail], res), do: do_invert_pairs(tail, [{b, a} | res])
  defp do_invert_pairs([[a, b] | tail], res), do: do_invert_pairs(tail, [[b, a] | res])

  @doc """
  13. The list-of-symbols? function takes a list lst as input. It returns true if all elements (possibly zero) contained in lst are symbols, or false otherwise.
  """
  defp list_of_symbols?(lst), do: do_list_of_symbols?(lst, true)
  # Base case
  defp do_list_of_symbols?(lst), do:
end

IO.inspect(Activity.positives([1, 2, 3, -1, -2, -3]))
IO.inspect(Activity.add_list([1, 2, 3]))
IO.inspect(Activity.invert_pairs([{1, 2}, {3, 4}, {5, 6}]))
IO.inspect(Activity.invert_pairs([[1, 2], [3, 4], [5, 6]]))
