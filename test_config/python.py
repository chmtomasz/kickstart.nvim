import pandas as pd


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
