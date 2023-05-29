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
          |> Enum.map(&helperFun/1)
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
  defp highlight_line(line, lst) when is_binary(line) do
    IO.inspect(lst)

    Enum.reduce(lst, line, fn element, acc ->
      new_line =
        case element do
          "string" ->
            if not Regex.match?(~r/(?<=<span)=/, acc) do
              acc = Regex.replace(~r/("[^"]*")/, acc, "<span class=\"string\">\\1</span>")
              acc = Regex.replace(~r/('[^']*')/, acc, "<span class=\"string\">\\1</span>")
            end

          "comment" ->
            acc = Regex.replace(~r/#(.*)$/, acc, "<span class=\"comment\">#\\1</span>")

          "parenthesis" ->
            acc = Regex.replace(~r/(\(|\))/, acc, "<span class=\"parenthesis\">\\1</span>")
            acc = Regex.replace(~r/\b(\w+)\(/, acc, "<span class=\"function\">\\1</span>")

          "number" ->
            acc = Regex.replace(~r/(\d+)/, acc, "<span class=\"number\">\\1</span>")

          "operator" ->
            acc = Regex.replace(~r/(\+|\-|\*)/, acc, "<span class=\"operator\">\\1</span>")

          "boolean" ->
            acc = Regex.replace(~r/\b(True|False)\b/, acc, "<span class=\"boolean\">\\1</span>")

          "method" ->
            acc = Regex.replace(~r/\.(\w+)/, acc, ".<span class=\"method\">\\1</span>")

          "keyword" ->
            acc =
              Regex.replace(
                ~r/\b(def|if|else|elif|for|while|in|return)\b/,
                acc,
                "<span class=\"keyword\">\\1</span>"
              )

          "decorator" ->
            acc = Regex.replace(~r/@(\w+)/, acc, "@<span class=\"decorator\">\\1</span>")
        end

      new_line
    end)
  end

  # defp charDetector([], list) do
  #   IO.inspect(Enum.uniq(list))
  # end

  defp charDetector([head | tail], list, status) do
    if tail == [] do
      list
    else
      case head do
        a when status == "string" ->
          if status == "string" && a in ["\"", "\'"] do
            charDetector(tail, ["string" | list], "")
          else
            charDetector(tail, list, "string")
          end

        a when a in ["\"", "\'"] ->
          if status == "string" && a in ["\"", "\'"] do
            charDetector(tail, ["string" | list], "")
          else
            charDetector(tail, list, "string")
          end

        a when a in ["{", "}", "(", ")", "[", "]"] ->
          charDetector(tail, ["parenthesis" | list], "")

        "#" ->
          charDetector([" "], ["comment" | list], "")

        a when a in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] ->
          charDetector(tail, ["number" | list], "")

        a when a in [":", ",", ";", "+", "-", "*", "/", "%", "^"] ->
          charDetector(tail, ["operator" | list], "")

        "@" ->
          charDetector(tail, ["decorator" | list], "")

        "." ->
          if status != "" do
            charDetector(tail, ["method" | list], "")
          end

        a when status in ["true", "false"] ->
          charDetector(tail, ["boolean" | list], "")

        a when status in ["def", "if", "else", "elif", "for", "while", "in", "return"] ->
          charDetector(tail, ["keyword" | list], "")

        " " ->
          charDetector(tail, list, "")

        _ ->
          charDetector(tail, list, status <> head)
      end
    end
  end

  defp helperFun(line) do
    highlight_line(line, Enum.uniq(charDetector(String.graphemes(line <> " "), [], "")))
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
