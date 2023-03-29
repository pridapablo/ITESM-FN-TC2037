"""
Program to expand a recursive definition of a language

Recieve the base case and the recursive rules, as well as the number
of iterations to expand the language.

Pablo Banzo Prida
2023-27-03
"""


def L_n(base, rules, n):
    """Expand the language recursively"""
    # Base case as L1
    final_L = [base]
    # Expand the language n times
    for i in range(n):
        new_base = []
        for item in base:
            for rule in rules:
                new_base.append(rule.replace("u", item))
        base = new_base
    final_L = base
    # Remove duplicates from final list using a set
    final_L = list(set(final_L))

    return final_L


def replace_item(string, rules, result):
    if rules == []:
        return result
    else:
        replace_item(item, rules[1:], result.append(
            rules[0].replace("u", item)))


if __name__ == "__main__":
    base = ["b"]
    print("The base case is: ", base)
    rules = ["aau", "ua", "ub"]
    print("The rules are: ", rules)
    n = int(input("Enter the number of iterations: "))
    print(L_n(base, rules, n))
