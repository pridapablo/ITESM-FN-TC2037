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

<id> ::= <letter> | <digit> | <id> <id> | <id> \_
<upper_id> ::= <upper_letter> <id>

<!--  General primitives -->

<letter> ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z | \_
<upper_letter> ::= A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

<!-- Guard expressions -->

<guard_expr> ::= <id>

<!--  EBNF translation of the above BNF -->

<!-- Module definition -->

MODULE ::= 'defmodule' MOD_NAME 'do' MOD_BODY 'end'
MOD_NAME ::= UPPER_ID
MOD_BODY ::= FUNCTION | FUNCTION MOD_BODY

<!-- Function definitions (considering pattern matching and guards) -->

FUNCTION ::= FUNC_DECLARATION FUNC_NAME FUNC_ARGS 'do' FUNC_BODY 'end' |
FUNC_DECLARATION FUNC_NAME FUNC_ARGS ', do:' FUNC_BODY |
FUNC_DECLARATION FUNC_NAME FUNC_ARGS 'when' GUARD_EXPR ', do:' FUNC_BODY
FUNC_DECLARATION ::= 'def' | 'defp'
FUNC_NAME ::= ID

FUNC_ARGS ::= '(' ARG_LIST ')'
ARG_LIST ::= ARG | ARG ',' ARG_LIST
ARG ::= ID

FUNC_BODY ::= STATEMENT | STATEMENT FUNC_BODY
STATEMENT ::= ID

<!-- General expressions -->

ID ::= LETTER | DIGIT | ID ID | ID '\_'
UPPER_ID ::= UPPER_LETTER ID

<!--  General primitives -->

LETTER ::= 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm' | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' | '\_'
UPPER_LETTER ::= 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M' | 'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z'
DIGIT ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'

<!-- Guard expressions -->

GUARD_EXPR ::= ID
