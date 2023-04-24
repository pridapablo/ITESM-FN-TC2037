defmodule Hw do
  @moduledoc """
  Documentation for `Hw`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hw.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Double the number

  ## Examples

      iex> Hw.double(0)
      0

      iex> Hw.double(1)
      2

      iex> Hw.double(4)
      8

      iex> Hw.double(-4)
      -8

  """
  def double(n), do: 2 * n
end
