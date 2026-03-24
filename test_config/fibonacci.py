# This script calculates the first 5 Fibonacci numbers

def fibonacci(n):
    if n <= 0:
        return []
    elif n == 1:
        return [0]
    elif n == 2:
        return [0, 1]

    fib_sequence = [0, 1]
    for i in range(2, n):
        fib_sequence.append(fib_sequence[-1] + fib_sequence[-2])
    return fib_sequence

# Main block to calculate the first 7 Fibonacci numbers
if __name__ == "__main__":
    from colorama import Fore, Style

    first_7_fibs = fibonacci(7)
    colored_fibs = ', '.join([f"{Fore.BLUE}{num}{Style.RESET_ALL}" for num in first_7_fibs])
    print("The first 7 Fibonacci numbers are:", colored_fibs)

