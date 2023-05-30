defmodule Lists do
  def factor_of_3(lst), do: do_factor_of_3(lst, [])
  defp do_factor_of_3([], acc), do: Enum.reverse(acc)

  defp do_factor_of_3([head | tail], acc) when rem(head, 3) == 0 do
    do_factor_of_3(tail, [head | acc])
  end

  defp do_factor_of_3([head | tail], acc), do: do_factor_of_3(tail, acc)
end

# print
IO.inspect(Lists.factor_of_3([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
