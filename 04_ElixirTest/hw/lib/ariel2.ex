# Functions to work with lists
# Designed by professor Ariel Ortiz (CEM)
#
# Gilberto Echeverria
# 2023-04-24

defmodule Hw.Ariel2 do
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
end
