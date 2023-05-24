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
        highlighted_text =
          text
          |> String.split("\n")
          |> Enum.map(&highlight_line/1)
          |> Enum.join("\n")

        File.write("06_FinalProject/example.html", highlighted_text)

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

    # Keywords
    line =
      Regex.replace(
        ~r/(\b(and|as|assert|break|class|continue|def|del|elif|else|except|exec|finally|for|from|global|if|import|in|is|lambda|not|or|pass|print|raise|return|try|while|with|yield)\b)/,
        line,
        "<span class=\"keyword\">\\0</span>"
      )

    line
  end
end

{:ok, path} = :file.get_cwd()
IO.puts(path)

Syntaxhighlighter.highlight("06_FinalProject/example.py")
