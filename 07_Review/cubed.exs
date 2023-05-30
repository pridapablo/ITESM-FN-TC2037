defmodule Lists do
  def cubed(lst), do: do_cubed(lst, [])
  defp do_cubed([], acc), do: Enum.reverse(acc)
  defp do_cubed([head | tail], acc), do: do_cubed(tail, [head * head * head | acc])
end

# print
IO.inspect(Lists.cubed([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
