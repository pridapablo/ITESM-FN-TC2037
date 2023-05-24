defmodule Syntaxhighlighter do
  @moduledoc """
  A basic Syntax Highlighter for Python code using Elixir.
  It will read a Python file and output an HTML file with highlighted syntax.
  """

  @doc """
  Reads a Python file and highlights its syntax.
  """
  def highlight(file) do
    expanded_path = Path.expand(file)

    IO.puts("Reading file: #{expanded_path}")

    case File.read(expanded_path) do
      {:ok, text} ->
        text
        |> String.split("\n")
        |> Enum.map(&highlight_line/1)
        |> Enum.join("\n")
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end

  @doc """
  Helper function to highlight a line of Python code.
  """
  defp highlight_line(line) when is_binary(line) do
    # Strings
    line = Regex.replace(~r/".*?"/, line, "<span class=\"string\">\\0</span>")

    # Comments
    line = Regex.replace(~r/#.*$/, line, "<span class=\"comment\">\\0</span>")

    line
  end
end

{:ok, path} = :file.get_cwd()
IO.puts(path)

Syntaxhighlighter.highlight("06_FinalProject/example.py")
