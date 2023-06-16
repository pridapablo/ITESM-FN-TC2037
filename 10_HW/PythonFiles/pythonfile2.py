print("Hello from pythonfile2.py")

def lenguaje (baseCase, rules, count):
    count += 1
    newCase = []
    for i in rules:
        for j in baseCase:
            newCase.append(i.replace("u", j))
    print(newCase)
    
    if count < 3:
        lenguaje(newCase, rules, count)   
    
lenguaje(["b"], ["aau", "ua", "ub"], 0)
        