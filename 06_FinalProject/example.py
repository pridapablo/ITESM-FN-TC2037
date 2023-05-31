# 34"yeah" print("hello") 
# Variable names
my_variable = 42
another_variable = "Hello"

# Parameters
def greet(name):
    print("Hello,", name)
    print('Hello, ' + name)

greet("Alice")

# Decorators
@decorator_function
def my_function():
    print("Decorated function")

# Dictionaries
my_dict = {
    'key': 'value1',
    'key': 'value2'
}

# Escaped characters
escaped_string = "This is a double quote: \""

# Arithmetic operations
a = 5 + 3
b = 10 - 2
c = 4 * 2
d = 16 / 4

# Comparison operators
if a > b:
    print("a is greater than b")

if c < d:
    print("c is less than d")

# Logical operators
if a > 0 and b > 0:
    print("Both a and b are positive")

if c > 0 or d > 0:
    print("At least one of c or d is positive")

# Control flow statements
for i in range(5):
    print(i)

while a > 0:
    print(a)
    a -= 1

# Class definition
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greet(self):
        print(f"Hello, my name is {self.name} and I am {self.age} years old.")

person = Person("Alice", 25)

person.greet()
