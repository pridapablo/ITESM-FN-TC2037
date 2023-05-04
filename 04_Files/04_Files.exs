# Functions to work with file Input/Output Perform Caesar Cipher on a file Also showing the use of
# the pipe operator

# Pablo Banzo Prida - 04/05/2023

defmodule FileIO do
  def char_shift(char, offset) do
    # Shifts a character by a given offset
    cond do
      # Check if the letter is uppercase
      65 <= char and char <= 90 -> Integer.mod(char - 65 + offset, 26) + 65
      # If the letter is lowecase
      97 <= char and char <= 122 -> Integer.mod(char - 97 + offset, 26) + 97
      # If the char is not a letter
      true -> char
    end
  end

  def line_shift(line, offset) do
    # Shifts a list of characters by a given offset Map uses the function and its arrity (number of
    # args it recieves), it takes each item of a list to use it as the argument of another function.
    # Example of map Enum.map([1,2,3], &:math.sqrt/1) to_string(Enum.map(to_charlist(line), fn char
    # -> char_shift(char, offset) end)) Using capture operator for the map (instead of a lambda fn)
    # to_string(Enum.map(to_charlist(line), &char_shift(&1, offset)))

    # Using Pipe Operator (passes the result to the next function)
    line
    |> to_charlist()
    |> IO.inspect()
    |> Enum.map(&char_shift(&1, offset))
    |> to_string()
  end

  def caesar_cipher(in_filename, out_filename, offset) do
    # Importing Files: No exclamation point has an iferror clause that avoids crashing
    # File.stream!("path/to/file.txt") |> Enum.each(&IO.puts/1) File.write("path/to/file.txt",
    # "Hello World")
    data =
      in_filename
      # Opens the file and returns a list of lines
      |> File.stream!()
      |> Enum.map(&line_shift(&1, offset))
      # Joins the list of lines into a single string
      |> Enum.join("")

    # Writes the string to the output file
    File.write(out_filename, data)
  end
end

IO.puts(FileIO.char_shift(90, 5))
IO.puts(FileIO.char_shift(100, 5))
IO.puts(FileIO.char_shift(89, 5))
IO.puts(FileIO.char_shift(70, 5))
IO.puts(FileIO.line_shift("HelloWorld", 15))

FileIO.caesar_cipher("04_Files/lorem.txt", "04_Files/output.txt", 5)
