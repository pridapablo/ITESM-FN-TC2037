<!-- BNF CFG for Elixir module and function definitions -->

<!-- Module definition -->
<module> ::= defmodule <mod_name> do <mod_body> end
<mod_name> ::= <upper_id>
<mod_body> ::= <function> | <function> <mod_body>

<!-- Function definitions (considering pattern matching and guards) -->
<function> ::= <func_declaration> <func_name> <func_args> do <func_body> end |
               <func_declaration> <func_name> <func_args>, do: <func_body> |
               <func_declaration> <func_name> <func_args> when <guard_expr>, do: <func_body>
<func_declaration> ::= def | defp
<func_name> ::= <id>

<func_args> ::= ( <arg_list> )
<arg_list> ::= <arg> | <arg> , <arg_list>
<arg> ::= <id>

<func_body> ::= <statement> | <statement> <func_body>
<statement> ::= <id>

<!-- General expressions -->
<id> ::= <letter> | <digit> | <id> <id> | <id> _
<upper_id> ::= <upper_letter> <id>

<!--  General primitives -->
<letter> ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z | _
<upper_letter> ::= A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

<!-- Guard expressions -->
<guard_expr> ::= <id>
