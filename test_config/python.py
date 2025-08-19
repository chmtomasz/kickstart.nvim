import pandas as pd


# write function that calculates fibonacci numbers
def fibonacci(n):
    if n <= 0:
        return []
    elif n == 1:
        return [0]
    elif n == 2:
        return [0, 1]
    
    fib_sequence = [0, 1]
    for i in range(2, n):
        next_value = fib_sequence[i - 1] + fib_sequence[i - 2]
        fib_sequence.append(next_value)
    
    return fib_sequence


def calc_fibonacci(n):
    for i in range(n):
        print(f"Fibonacci number {i} is {fibonacci(i)}")

def main():
    # Create a sample DataFrame
    data = {
        'Name': ['Alice', 'Bob', 'Charlie'],
        'Age': [24, 27, 22],
        'City': ['New York', 'Los Angeles', 'Chicago']
    }
    df = pd.DataFrame(data)

    # Display the DataFrame
    print("Sample DataFrame:")
    print(df)

    # Add a new column
    df['Is_Adult'] = df['Age'] > 18

    # Display the updated DataFrame
    print("\nUpdated DataFrame:")
    print(df)

    

if __name__ == "__main__":
    main()
