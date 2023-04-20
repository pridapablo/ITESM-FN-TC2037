defmodule Listas do
  def sum(list) do
    if list == [] do
      0
    else
      # hd = head, tl = tail
      hd(list) + sum(tl(list))
    end
  end

  @doc """
  Using pattern matching to indentify the base case
  """
  def sum2([]), do: 0
  # hd = head, tl = tail
  def sum2(list), do: hd(list) + sum2(tl(list))

  @doc """
  Using pattern matching to deconstruct the list
  """
  def sum3([]), do: 0
  def sum3([head | tail]), do: head + sum3(tail)

  @doc """
  Enlist function. Creates a new list where each element of the input is itself in a list
  """
  def enlist(list), do: do_enlist(list, [])

  defp do_enlist([], res), do: Enum.reverse(res)
  defp do_enlist([head | tail], res), do: do_enlist(tail, [head | res])
end
