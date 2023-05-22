<!-- BNF CFG for Elixir module and function definitions -->
<!-- Module definition -->

<module> ::= defmodule <mod_name> do <mod_body> end
<mod_name> ::= <upper_id>
<mod_body> ::= <function> | <function> <mod_body>

<!-- Function definition -->

<function> ::= <func_declaration> <func_name> <func_args> do <func_body> end
<func_declaration> ::= def | defp
<func_name> ::= <id>

<func_args> ::= ( <arg_list> )
<arg_list> ::= <arg> | <arg> , <arg_list>
<arg> ::= <id>

<func_body> ::= <statement> | <statement> <func_body>
<statement> ::= <id>

<!-- General expressions -->

<id> ::= <letter><id*rest> | <letter>
<upper_id> ::= <upper_letter><id_rest> | <upper_letter>
<id_rest> ::= <letter> | <digit> | * | <id*rest> <letter> | <id_rest> <digit> | <id_rest> *

<!--  General primitives -->

<letter> ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
<upper_letter> ::= A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
