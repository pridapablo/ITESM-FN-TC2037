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

        html_content = build_html_content(highlighted_text)
        File.write("06_FinalProject/example.html", html_content)

      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end

  @doc """
  Helper function to highlight a line of Python code using regex and output HTML.

  Issues:
  - Everything matches when it's inside a comment or a string. For example:
      # 34"yeah" print("hello") should be highlighted as a comment, but it's not.
  - / is matching escaped characters, so it is not an operator currently.
  - keyword "class" is not implemented because it will match "class" in the html tag.
  - Multiline strings don't seem to work.
  Extra things to try to highlight in the syntax highlighter:
  - Variable names (words that are not keywords, functions, methods, etc.)
  - Parameters (words followed by a comma and between parenthesis. Consider a function with only one parameter)
  - Decorators (words preceded by @)
  - Dictionaries (words followed by a colon)
  """
  defp highlight_line(line) when is_binary(line) do
    # Strings
    line = Regex.replace(~r/("[^"]*")/, line, "<span class=\"string\">\\1</span>")
    # Multiline strings
    line = Regex.replace(~r/("""[^"]*""")/, line, "<span class=\"string\">\\1</span>")
    line = Regex.replace(~r/('''[^']*''')/, line, "<span class=\"string\">\\1</span>")

    # Numbers
    line = Regex.replace(~r/(\d+)/, line, "<span class=\"number\">\\1</span>")

    # Keywords
    line =
      Regex.replace(
        ~r/\b(def|if|else|elif|for|while|in|return)\b/,
        line,
        "<span class=\"keyword\">\\1</span>"
      )

    # Operators (except /)
    line = Regex.replace(~r/(\+|\-|\*)/, line, "<span class=\"operator\">\\1</span>")

    # Booleans
    line = Regex.replace(~r/\b(True|False)\b/, line, "<span class=\"boolean\">\\1</span>")

    # Functions (words followed by a parenthesis)
    line = Regex.replace(~r/\b(\w+)\(/, line, "<span class=\"function\">\\1</span>(")

    # Parenthesis
    line = Regex.replace(~r/(\(|\))/, line, "<span class=\"parenthesis\">\\1</span>")

    # Methods (words preceded by a dot)
    line = Regex.replace(~r/\.(\w+)/, line, ".<span class=\"method\">\\1</span>")

    # Decorators (words preceded by @)
    line = Regex.replace(~r/@(\w+)/, line, "@<span class=\"decorator\">\\1</span>")

    # Comments
    line = Regex.replace(~r/#(.*)$/, line, "<span class=\"comment\">#\\1</span>")

    line
  end

  defp build_html_content(highlighted_text) do
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Syntax Highlighter</title>
        <style>
            .string { color: green; }
            .comment { color: gray; }
            .keyword { color: blue; }
            .number { color: purple; }
            .operator { color: red; }
            .boolean { color: orange; }
            .function { color: brown; }
            .parenthesis { color: brown; }
            .method { color: brown; }
            .decorator { color: grey; }

        </style>
    </head>
    <body>
    <pre>
    #{highlighted_text}
    </pre>
    </body>
    </html>
    """
  end
end

{:ok, path} = :file.get_cwd()
IO.puts(path)

Syntaxhighlighter.highlight("06_FinalProject/example.py")
