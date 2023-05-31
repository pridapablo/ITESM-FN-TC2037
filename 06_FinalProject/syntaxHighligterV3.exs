defmodule Syntax do
  @doc """
  Reads a Python file line by line and highlights its syntax.
  """
  def highlight(file) do
    expanded_path = Path.expand(file)

    IO.puts("Reading file: #{expanded_path}")

    stream = File.stream!(expanded_path)

    # Using a stream to avoid reading the whole file into memory
    highlighted_lines_stream =
      stream
      |> Stream.map(&String.trim/1)
      |> Stream.map(&highlight_line/1)

    highlighted_text = Enum.join(highlighted_lines_stream, "\n")

    html_content = parse_html(highlighted_text)
    File.write("06_FinalProject/example.html", html_content)
  end

  defp highlight_line(line) do
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

  defp parse_html(highlighted_text) do
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

Syntax.highlight("06_FinalProject/example.py")
