# Activity 3.1 - Regular languages

## Names:

- Pablo Banzo Prida
- Gabriel Rodríguez de los Reyes

## Exercises:

1. Give a recursive definition of the set of strings over $\{a, b\}$ that
   contain at least one $b$ and have an even number of $a$’s before the
   first $b$.
   For example: $aab$, $bab$ and $aaaabbabababa$ are in the set,
   but $abb$, $aaab$ and $aa$ are not.

   _**SOLUTION:**_

   1. **Basis:**: $b \in L$
   2. **Recursive step:** If $u \in L$ then $aau \in L$ and $bu \in L$.
   3. **Closure:** A string $u \in L$ only if it can be obtained from the
      basis using a finite number of applications of the recursive step, and it contains at least one $b$ and has an even number of $a$’s before the first $b$.

<br>

2.  Let $X = \{aa, bb\}$ and $Y = \{\lambda, b, ab\}$.

    a. List the strings in set $XY$

    _**Answer:**_

    | #   | string | #   | string | #   | string   |
    | --- | ------ | --- | ------ | --- | -------- |
    | 1   | $aa$   | 2   | $aab $ | 3   | $ aaab $ |
    | 4   | $bb$   | 5   | $bbb $ | 6   | $ bbab $ |

    b. How many strings of length 6 are there in $X^*$?

    _**Answer:**_ the number of strings of length 6 in $X^*$ is **8** since 2 (possible strings) to the power of 3 (combinations of $X^*$ that are of length 6) is 8.

    Considering that combinations of $X^*$ that are of length 6 can be obtained from $X^3$ (the cartesian product of $X \times X \times X$), thus:

    $$X^2 = \{aaaa, aabb, bbaa, bbbbb\}$$

    $$X^3 = X^2 × X = \{aaaaaa, aaaabb, aabbaa, aabbbb, bbaaaa, bbaabb, bbbbbaa, bbbbbb\}$$

    $$|X^3| = 8$$

    c. List the strings in set $Y^*$ of length three or less

    _**Answer:**_ Following the same logic as in the previous question:

    $$Y^2 = \{ \lambda, b, ab, bb, bab, abb, abab \}$$

    From the before mentioned set, we can obtain the following set by applying the restriction of length 3 or less:

    $$Z_1 = \{ \lambda, b, ab, bb, bab, abb \}$$

    Then, we can do the same process with the set $Y^3$:

    $$Y^3 = \{ \lambda, b, ab, bb, bab, abb, abab, bbb, bbab, babb, babab, abbb, abbab, ababb, ababab \}$$

    $$Z_2 = \{ \lambda, b, ab, bb, bab, abb, bbb\}$$

    Assuming that all strings of length 3 or less are in $Y^3$, we don't have to express $Y^4 ...\text{ }Y^n$. Thus:

    Also, since $Z_1 \subset Z_2$, we can conclude that the strings in set $Y^*$ of length three or less are the ones in $Z_2$:

    | #   | string    | #   | string | #   | string |
    | --- | --------- | --- | ------ | --- | ------ |
    | 1   | $\lambda$ | 2   | $b $   | 3   | $ ab $ |
    | 4   | $bb$      | 5   | $ bab$ | 6   | $ abb$ |
    | 7   | $ bbb$    |     |        |     |        |

    d. List the strings in set $X^* Y^*$ of length four or less

    _**Answer:**_

    Considering the following sets:

    $$X = \{aa, bb\}$$

    $$X^2 = \{aaaa, aabb, bbaa, bbbbb\}$$

    $$Y = \{ \lambda, b, ab\}$$

    $$Y^3 = \{ \lambda, b, ab, bb, bab, abb, abab, bbb, bbab, babb, babab, abbb, abbab, ababb, ababab \}$$

    Where strings of length 4 or less are:

    (From $X$) aa,bb

    (From $X^2$) aaaa, aabb, bbaa

    (From $Y$) $\lambda$, b, ab

    (From $Y^3$) bb, bab, abb, abab, bbb, bbab, babb

    <!-- | #   | string    | #   | string | #   | string | -->
    <!-- | --- | --------- | --- | ------ | --- | ------ | -->
    <!-- | 1   | $\lambda$ | 2   | $a$    | 3   | $b$    | -->
    <!-- | 4   | $ab$      | 5   | $aab$  | 6   | $aba$  | -->
    <!-- | 7   | $abb$     | 8   | $aabb$ | 9   | $baa$  | -->
    <!-- | 10  | $bab$     | 11  | $bba$  | 12  | $bb$   | -->
    <!-- | 13  | $aaa$     | 14  | $aab$  | 15  | $abb$  | -->
    <!-- | 16  | $bbb$     | 17  | $aaab$ | 18  | $aabb$ | -->
    <!-- | 19  | $abab$    | 20  | $abbb$ | 21  | $baa$  | -->
    <!-- | 22  | $baab$    | 23  | $babb$ | 24  | $bbbb$ | -->

3.  Give a recursive definition of the set $\{ a^ib^j | 0 ≤ i ≤ j ≤ 2i\}$

Certainly! Here's the detailed explanation of the recursive step for the set { $a^ib^j$ $|$ $0 \leq i \leq j \leq 2i$ }, written in Markdown with LaTeX equations:

_**SOLUTION:**_

- **Basis**: $λ \in L$
- **Recursive Step**:

In the recursive step, we assume that a string $w = a^ib^j$ is already in the set, where $0 \leq i \leq j \leq 2i$. We then construct three new strings that are also in the set, as follows:

- aw: This string is created by appending an 'a' to the end of $w$. Given that $w$ already has a 'b' and an 'a', the number of 'a' in $aw$ is $i+1$, and the number of 'b' is $j$. In this scenario the first conidition, $i+1 \geq 0$, is always true. The second condition, $j \leq 2(i+1)$ is already assumed to be true for $w$, given that
  $j \leq 2i$.

- wb: This string is created by pending a 'b' to the beginning of $w$. Given that $w$ already has a 'b' and an 'a', the number of 'b' in $wb$ is $j+1$, and the number of 'a' is $i$. The opposite of the previous scenario. In this scenario e first conidition, $i \geq 0$, is always true. The second condition $i \leq j+1$ is already assumed to be true for $w$, given the pre condition $i \leq j$.

- $\epsilon$: This string is added to the set only if $j = 2i$. This condition ensures that the number of 'b's in $w$ is exactly twice the number of 'a's. Since $\epsilon$ has no 'a's or 'b's, it satisfies this condition.

- **Closure**: the recursive definition generates all strings that can be formed by concatenating any number of a's and b's, recursivley defining $a^ib^i$| 0 ≤ i ≤ j ≤ 2i\

4.  Let $L$ be the set of strings over $\{a, b\}$ generated by the recursive definition:

    **I. Basis:** $b \in L$

    **II. Recursive Step**: If $u \in L$ then $ub \in L$, $uab \in L$, $uba \in
    L$ and $bua \in L$

    **III. Closure**: A string $u \in L$ only if it can be obtained from the
    basis using a finite number of applications of the recursive step.

    **a.** List the elements in the sets $L_0, L_1, L_2$

    _**Answer:**_

    Considering that $L_0$ is the set of strings that come from the basis, applying cero recursions, we have that:

    $$L_0 = \{b\} \text{ (the basis)}$$

    Now, considering that $L_1$ is the set of strings that come from the basis, applying one recursion, we can consider the following cases:

    1. $ub | u = b \rightarrow b b \in L_1$
    2. $uab | u = b \rightarrow b ab \in L_1$
    3. $uba | u = b \rightarrow b ba \in L_1$
    4. $bua | u = b \rightarrow b b a \in L_1$ (same as the previous case)

    Thus, we have that:

    $$L_1 = \{bb, bab, bba\} \text{ (basis + recursive step)}$$

    Finally, considering that $L_2$ is the set of strings that come from the basis, applying two recursions, we can consider the following cases (where $u$ = $bb, bab, bba$):

    For $u = bb$:

    1. $ub | u = bb \rightarrow bb b \in L_2$
    2. $uab | u = bb \rightarrow bb ab \in L_2$
    3. $uba | u = bb \rightarrow bb ba \in L_2$
    4. $bua | u = bb \rightarrow b bb a \in L_2$ (same as previous case)

    For $u = bab$:

    1. $ub | u = bab \rightarrow bab b \in L_2$
    2. $uab | u = bab \rightarrow bab ab \in L_2$
    3. $uba | u = bab \rightarrow bab ba \in L_2$
    4. $bua | u = bab \rightarrow b bab a \in L_2$

    For $u = bba$:

    1. $ub | u = bba \rightarrow bba b \in L_2$
    2. $uab | u = bba \rightarrow bba ab \in L_2$
    3. $uba | u = bba \rightarrow bba ba \in L_2$
    4. $bua | u = bba \rightarrow b bba a \in L_2$

    Thus, we have that:

    $$L_2 = \{bbb, bbab, bbba, babb, babab, babba, bbaba, bbaab, bbbaa\} \text{ (basis + 2x recursive step)}$$

    **b.** Is the string $bbaaba$ in $L$? If so, trace how it is produced.
    If not, explain why not.

    _**Answer:**_

    $$bbaaba \notin L$$

    Analyzing the string we can observe that there are two "a" characters in a row, which is not allowed by the definition of $L$, due to the fact that no recursive step (applied to the basis) can produce a string with two consecutive "a" characters.

    **c.** Is the string $bbaaaabb$ in $L$? If so, trace how it is produced. If not, explain why not.

    _**Answer:**_

    $$bbaaaabb \notin L$$

    Analogus to the previous answer, it is not possible to produce a string with two consecutive "a" characters, so the string "bbaaaabb" is not in $L$, since it contains the substring "aa".

5.  Prove, using induction on the length of a string, that $(w^R)^R = w$ for all
    string $w \in \Sigma$

    _**SOLUTION:**_

    **Base Case**: Let $w$ be a empty string, where $w = λ$. Then, $w^R = λ$ and $(w^R)^R = λ$. Thus, $(w^R)^R = w$.

    **Inductive Step**: Let $w$ be a string of length $n$ (where 0 ≤ n), where $w = a_1a_2...a_n$. Then, $w^R = a_n...a_2a_1$ and $(w^R)^R = a_1a_2...a_n$. Thus, $(w^R)^R = w$.

    Lets assume that $(u^R)^R = u$ for all strings $u$ of length $n$(where 0 ≤ n). Lets define w as n+1, where w can be rewritten as $w = xu$, in which x is a string of length n and u is a single character.

    Then, $w^R = u^Rx^R$

    and $(w^R)^R = (x^Ru^R)^R$.

    By the inductive hypothesis we can say $(w^R)^R = (x^R)^Ru$.

    or, $(w^R)^R = xu$

    Thus, $(w^R)^R = w$.

    This proves that $(w^R)^R = w$ for all strings $w \in \Sigma$.
