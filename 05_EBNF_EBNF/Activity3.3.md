<!-- BNF CFG for Elixir module and function definitions -->
<!-- Module definition -->

<module> ::= defmodule <mod_name> do <mod_body> end
<mod_name> ::= <id>
<mod_body> ::= <function> | <function> <mod_body>

<!-- Function definition -->

<function> ::= <func_declaration> <func_name> <func_args> do <func_body> end
<func_declaration> ::= def | defp
<func_name> ::= <id>

<!--  Arguments -->
<func_args> ::= ( <arg_list> )
<arg_list> ::= <arg> | <arg> , <arg_list>
<arg> ::= <id>

<!-- Function body -->
<func_body> ::= <statement> | <statement> <func_body>
<statement> ::= <assignment> | <if_statement> | <case_statement> | <function_call>
<assignment> ::= <id> = <expr>
<if_statement> ::= if <expr> do <func_body> end
<case_statement> ::= case <expr> do <case_body> end
<case_body> ::= <case_clause> | <case_clause> <case_body>
<case_clause> ::= <expr> -> <func_body>
<function_call> ::= <func_name> <func_args>

<!-- General primitives -->

<id> ::= <letter> | <id> <letter> | <id> <digit>
<letter> ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z | \_ | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
