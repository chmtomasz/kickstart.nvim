import pandas as pd
import numpy as np
import time
import unittest


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


def fibonacci_numpy(n):
    """
    Calculate the nth Fibonacci number using numpy matrix multiplication.
    This approach is more efficient for large numbers.
    """
    if n <= 0:
        return 0
    elif n == 1:
        return 1

    # Fibonacci matrix: [[1, 1], [1, 0]]
    # F(n) = [[1, 1], [1, 0]]^(n-1) * [1, 0]
    fib_matrix = np.array([[1, 1], [1, 0]], dtype=np.int64)

    # Matrix exponentiation for efficiency
    result_matrix = np.linalg.matrix_power(fib_matrix, n - 1)

    return result_matrix[0, 0]


def fibonacci_numpy_sequence(n):
    """
    Generate Fibonacci sequence up to n numbers using numpy.
    Uses vectorized operations for better performance.
    """
    if n <= 0:
        return np.array([])
    elif n == 1:
        return np.array([0])
    elif n == 2:
        return np.array([0, 1])

    # Initialize array
    fib_seq = np.zeros(n, dtype=np.int64)
    fib_seq[0] = 0
    fib_seq[1] = 1

    # Vectorized calculation
    for i in range(2, n):
        fib_seq[i] = fib_seq[i-1] + fib_seq[i-2]

    return fib_seq


def calc_fibonacci(n):
    for i in range(n):
        print(f"Fibonacci number {i} is {fibonacci(i)}")


def calc_fibonacci_numpy(n):
    """Compare original and numpy implementations"""
    print("=== Original Implementation ===")
    for i in range(n):
        print(f"Fibonacci number {i} is {fibonacci(i)}")

    print("\n=== Numpy Single Number Implementation ===")
    for i in range(n):
        print(f"Fibonacci number {i} is {fibonacci_numpy(i)}")

    print("\n=== Numpy Sequence Implementation ===")
    fib_sequence = fibonacci_numpy_sequence(n)
    for i, fib_num in enumerate(fib_sequence):
        print(f"Fibonacci number {i} is {fib_num}")


def calculate_primes_up_to_100():
    """
    Calculate all prime numbers up to 100 using the Sieve of Eratosthenes algorithm.
    Returns a list of prime numbers.
    """
    limit = 100
    
    # Create a boolean array "prime[0..limit]" and initialize all entries as true
    prime = [True for _ in range(limit + 1)]
    prime[0] = prime[1] = False  # 0 and 1 are not prime numbers
    
    p = 2
    while p * p <= limit:
        # If prime[p] is not changed, then it is a prime
        if prime[p]:
            # Update all multiples of p
            for i in range(p * p, limit + 1, p):
                prime[i] = False
        p += 1
    
    # Collect all prime numbers
    primes = []
    for i in range(2, limit + 1):
        if prime[i]:
            primes.append(i)
    
    return primes


def is_prime(n):
    """
    Check if a number is prime.
    Returns True if the number is prime, False otherwise.
    """
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    
    # Check odd divisors up to sqrt(n)
    for i in range(3, int(n ** 0.5) + 1, 2):
        if n % i == 0:
            return False
    
    return True


def calculate_primes_numpy(limit):
    """
    Calculate prime numbers up to a given limit using numpy for better performance.
    Uses the Sieve of Eratosthenes algorithm with numpy arrays.
    """
    if limit < 2:
        return np.array([])
    
    # Create boolean array
    sieve = np.ones(limit + 1, dtype=bool)
    sieve[0] = sieve[1] = False  # 0 and 1 are not prime
    
    # Sieve of Eratosthenes
    for i in range(2, int(limit**0.5) + 1):
        if sieve[i]:
            # Mark multiples of i as not prime
            sieve[i*i:limit+1:i] = False
    
    # Return array of prime numbers
    return np.where(sieve)[0]


def print_primes_up_to_100():
    """Print all prime numbers up to 100 with formatting."""
    primes = calculate_primes_up_to_100()
    
    print("Prime numbers up to 100:")
    print("=" * 40)
    
    # Print primes in rows of 10
    for i, prime in enumerate(primes):
        print(f"{prime:3d}", end="  ")
        if (i + 1) % 10 == 0:
            print()  # New line every 10 primes
    
    if len(primes) % 10 != 0:
        print()  # Final newline if needed
    
    print(f"\nTotal count: {len(primes)} prime numbers")
    
    # Compare with numpy implementation
    primes_numpy = calculate_primes_numpy(100)
    print(f"Numpy implementation found: {len(primes_numpy)} prime numbers")
    print(f"Results match: {np.array_equal(np.array(primes), primes_numpy)}")


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
    # suggestion: call calc_fibonacci with n = 10
    print("\n" + "="*50)
    print("Testing Fibonacci Functions:")
    print("="*50)

    # Test the new numpy fibonacci functions
    calc_fibonacci_numpy(10)

    print("\n" + "="*50)
    print("Performance comparison for larger numbers:")
    print("="*50)

    # Test single larger number
    test_num = 30
    print(f"\nFibonacci({test_num}):")
    print(f"Original: {fibonacci(test_num)}")
    print(f"Numpy: {fibonacci_numpy(test_num)}")

    # Test sequence generation
    print(f"\nFirst 15 Fibonacci numbers (numpy sequence):")
    fib_seq = fibonacci_numpy_sequence(15)
    print(fib_seq)

    # Test prime numbers
    print("\n" + "="*50)
    print("Testing Prime Number Functions:")
    print("="*50)
    print_primes_up_to_100()


if __name__ == "__main__":
    main()


class TestFibonacciImplementations(unittest.TestCase):
    """Unit tests for all fibonacci implementations"""

    def setUp(self):
        """Set up test data"""
        # Known fibonacci sequence for validation
        self.known_fib = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]

    def test_fibonacci_basic(self):
        """Test basic fibonacci function with known values"""
        for i, expected in enumerate(self.known_fib):
            with self.subTest(i=i):
                result = fibonacci(i)
                if isinstance(result, list):
                    self.assertEqual(result[-1] if result else 0, expected,
                                   f"fibonacci({i}) should return sequence ending with {expected}")
                else:
                    self.assertEqual(result, expected, f"fibonacci({i}) should equal {expected}")

    def test_fibonacci_numpy_single(self):
        """Test numpy single number fibonacci function"""
        for i, expected in enumerate(self.known_fib):
            with self.subTest(i=i):
                result = fibonacci_numpy(i)
                self.assertEqual(result, expected, f"fibonacci_numpy({i}) should equal {expected}")

    def test_fibonacci_numpy_sequence(self):
        """Test numpy sequence fibonacci function"""
        for n in range(1, len(self.known_fib)):
            with self.subTest(n=n):
                result = fibonacci_numpy_sequence(n)
                expected = np.array(self.known_fib[:n])
                np.testing.assert_array_equal(result, expected,
                                            f"fibonacci_numpy_sequence({n}) should match known sequence")

    def test_edge_cases(self):
        """Test edge cases for all implementations"""
        # Test zero and negative inputs
        self.assertEqual(fibonacci_numpy(0), 0)
        self.assertEqual(fibonacci_numpy(-1), 0)
        self.assertEqual(fibonacci_numpy(-5), 0)

        # Test empty sequences
        np.testing.assert_array_equal(fibonacci_numpy_sequence(0), np.array([]))
        np.testing.assert_array_equal(fibonacci_numpy_sequence(-1), np.array([]))

        # Test single element sequences
        np.testing.assert_array_equal(fibonacci_numpy_sequence(1), np.array([0]))
        np.testing.assert_array_equal(fibonacci_numpy_sequence(2), np.array([0, 1]))

    def test_consistency_between_implementations(self):
        """Test that all implementations return consistent results"""
        test_range = range(0, 20)
        for i in test_range:
            with self.subTest(i=i):
                # Get results from different implementations
                original_result = fibonacci(i)
                numpy_single = fibonacci_numpy(i)
                numpy_seq = fibonacci_numpy_sequence(i+1)

                # Handle list vs single value from original fibonacci
                if isinstance(original_result, list):
                    original_value = original_result[-1] if original_result else 0
                else:
                    original_value = original_result

                # Check consistency
                self.assertEqual(numpy_single, original_value,
                               f"Inconsistent results at position {i}: numpy_single={numpy_single}, original={original_value}")

                if len(numpy_seq) > i:
                    self.assertEqual(numpy_seq[i], original_value,
                                   f"Inconsistent results at position {i}: numpy_seq[{i}]={numpy_seq[i]}, original={original_value}")

    def test_large_numbers(self):
        """Test with larger fibonacci numbers"""
        large_indices = [30, 35, 40]
        for i in large_indices:
            with self.subTest(i=i):
                result = fibonacci_numpy(i)
                self.assertIsInstance(result, (int, np.integer))
                self.assertGreater(result, 0)

                # Verify fibonacci property: F(n) = F(n-1) + F(n-2) for n > 1
                if i > 1:
                    f_n_minus_1 = fibonacci_numpy(i-1)
                    f_n_minus_2 = fibonacci_numpy(i-2)
                    self.assertEqual(result, f_n_minus_1 + f_n_minus_2,
                                   f"Fibonacci property violated at F({i})")


class TestPrimeImplementations(unittest.TestCase):
    """Unit tests for prime number implementations"""

    def setUp(self):
        """Set up test data"""
        # Known prime numbers up to 100
        self.known_primes_100 = [
            2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97
        ]

    def test_calculate_primes_up_to_100(self):
        """Test basic prime calculation function"""
        result = calculate_primes_up_to_100()
        self.assertEqual(result, self.known_primes_100)
        self.assertEqual(len(result), 25)  # There are 25 primes up to 100

    def test_calculate_primes_numpy(self):
        """Test numpy prime calculation function"""
        result = calculate_primes_numpy(100)
        expected = np.array(self.known_primes_100)
        np.testing.assert_array_equal(result, expected)

    def test_is_prime_function(self):
        """Test individual prime checking function"""
        # Test known primes
        for prime in self.known_primes_100:
            with self.subTest(prime=prime):
                self.assertTrue(is_prime(prime), f"{prime} should be prime")

        # Test known non-primes
        non_primes = [0, 1, 4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20, 21, 22, 24, 25, 26, 27, 28, 30]
        for non_prime in non_primes:
            with self.subTest(non_prime=non_prime):
                self.assertFalse(is_prime(non_prime), f"{non_prime} should not be prime")

    def test_edge_cases_primes(self):
        """Test edge cases for prime functions"""
        # Test small numbers
        self.assertFalse(is_prime(0))
        self.assertFalse(is_prime(1))
        self.assertTrue(is_prime(2))
        self.assertTrue(is_prime(3))

        # Test negative numbers
        self.assertFalse(is_prime(-1))
        self.assertFalse(is_prime(-5))

        # Test empty results for small limits
        self.assertEqual(len(calculate_primes_numpy(1)), 0)
        self.assertEqual(len(calculate_primes_numpy(0)), 0)

    def test_consistency_between_prime_implementations(self):
        """Test that both prime implementations return consistent results"""
        basic_result = calculate_primes_up_to_100()
        numpy_result = calculate_primes_numpy(100)
        
        # Convert to same type for comparison
        np.testing.assert_array_equal(np.array(basic_result), numpy_result)

    def test_larger_prime_ranges(self):
        """Test prime calculation for larger ranges"""
        limits = [50, 200, 500]
        for limit in limits:
            with self.subTest(limit=limit):
                basic_primes = [i for i in range(2, limit + 1) if is_prime(i)]
                numpy_primes = calculate_primes_numpy(limit)
                
                np.testing.assert_array_equal(np.array(basic_primes), numpy_primes,
                                            f"Prime calculations should match for limit {limit}")


class TestFibonacciPerformance(unittest.TestCase):
    """Performance benchmark tests for fibonacci implementations"""

    def setUp(self):
        """Set up performance test parameters"""
        self.small_n = 20
        self.medium_n = 30
        self.large_n = 40

    def time_function(self, func, *args, runs=5):
        """Helper function to time execution"""
        times = []
        for _ in range(runs):
            start_time = time.time()
            func(*args)
            end_time = time.time()
            times.append(end_time - start_time)
        return min(times)  # Return best time

    def test_performance_comparison_small(self):
        """Compare performance for small fibonacci numbers"""
        print(f"\n=== Performance Test (n={self.small_n}) ===")

        # Time original fibonacci (if it returns single values)
        time_original = self.time_function(fibonacci, self.small_n)

        # Time numpy single
        time_numpy_single = self.time_function(fibonacci_numpy, self.small_n)

        # Time numpy sequence
        time_numpy_seq = self.time_function(fibonacci_numpy_sequence, self.small_n)

        print(f"Original fibonacci: {time_original:.6f}s")
        print(f"Numpy single: {time_numpy_single:.6f}s")
        print(f"Numpy sequence: {time_numpy_seq:.6f}s")

        # All should complete in reasonable time
        self.assertLess(time_original, 1.0)
        self.assertLess(time_numpy_single, 1.0)
        self.assertLess(time_numpy_seq, 1.0)

    def test_performance_comparison_large(self):
        """Compare performance for larger fibonacci numbers"""
        print(f"\n=== Performance Test (n={self.large_n}) ===")

        # Time numpy implementations (original might be too slow)
        time_numpy_single = self.time_function(fibonacci_numpy, self.large_n)
        time_numpy_seq = self.time_function(fibonacci_numpy_sequence, self.large_n)

        print(f"Numpy single: {time_numpy_single:.6f}s")
        print(f"Numpy sequence: {time_numpy_seq:.6f}s")

        # Should still be fast
        self.assertLess(time_numpy_single, 1.0)
        self.assertLess(time_numpy_seq, 1.0)

    def test_sequence_generation_efficiency(self):
        """Test efficiency of generating multiple fibonacci numbers"""
        n = 25

        # Time individual calls
        start_time = time.time()
        individual_results = [fibonacci_numpy(i) for i in range(n)]
        individual_time = time.time() - start_time

        # Time sequence generation
        start_time = time.time()
        sequence_result = fibonacci_numpy_sequence(n)
        sequence_time = time.time() - start_time

        print(f"\n=== Sequence Generation Efficiency (n={n}) ===")
        print(f"Individual calls: {individual_time:.6f}s")
        print(f"Sequence generation: {sequence_time:.6f}s")
        print(f"Speedup: {individual_time / sequence_time:.2f}x")

        # Verify results are the same
        np.testing.assert_array_equal(sequence_result, np.array(individual_results))

        # Sequence generation should be faster for multiple values
        self.assertLess(sequence_time, individual_time)


class TestPrimePerformance(unittest.TestCase):
    """Performance benchmark tests for prime number implementations"""

    def time_function(self, func, *args, runs=3):
        """Helper function to time execution"""
        times = []
        for _ in range(runs):
            start_time = time.time()
            func(*args)
            end_time = time.time()
            times.append(end_time - start_time)
        return min(times)

    def test_prime_performance_comparison(self):
        """Compare performance between basic and numpy prime implementations"""
        limits = [100, 1000, 5000]
        
        for limit in limits:
            with self.subTest(limit=limit):
                print(f"\n=== Prime Performance Test (limit={limit}) ===")
                
                # Time basic implementation (using is_prime for each number)
                start_time = time.time()
                basic_primes = [i for i in range(2, limit + 1) if is_prime(i)]
                basic_time = time.time() - start_time
                
                # Time numpy implementation
                numpy_time = self.time_function(calculate_primes_numpy, limit)
                
                print(f"Basic implementation: {basic_time:.6f}s (found {len(basic_primes)} primes)")
                print(f"Numpy implementation: {numpy_time:.6f}s")
                if basic_time > 0:
                    print(f"Speedup: {basic_time / numpy_time:.2f}x")
                
                # Both should complete in reasonable time
                self.assertLess(basic_time, 10.0)
                self.assertLess(numpy_time, 10.0)


def run_fibonacci_tests():
    """Run all fibonacci tests"""
    print("Running Fibonacci Implementation Tests...")
    print("=" * 60)

    # Create test suite
    test_suite = unittest.TestSuite()

    # Add test cases
    test_suite.addTest(unittest.makeSuite(TestFibonacciImplementations))
    test_suite.addTest(unittest.makeSuite(TestFibonacciPerformance))

    # Run tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(test_suite)

    return result.wasSuccessful()


def run_prime_tests():
    """Run all prime number tests"""
    print("Running Prime Number Implementation Tests...")
    print("=" * 60)

    # Create test suite
    test_suite = unittest.TestSuite()

    # Add test cases
    test_suite.addTest(unittest.makeSuite(TestPrimeImplementations))
    test_suite.addTest(unittest.makeSuite(TestPrimePerformance))

    # Run tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(test_suite)

    return result.wasSuccessful()


def run_all_tests():
    """Run all tests for fibonacci and prime implementations"""
    print("Running All Mathematical Function Tests...")
    print("=" * 70)
    
    fib_success = run_fibonacci_tests()
    print("\n" + "=" * 70)
    prime_success = run_prime_tests()
    
    print("\n" + "=" * 70)
    print("SUMMARY:")
    print(f"Fibonacci tests: {'PASSED' if fib_success else 'FAILED'}")
    print(f"Prime tests: {'PASSED' if prime_success else 'FAILED'}")
    print(f"Overall: {'ALL TESTS PASSED' if fib_success and prime_success else 'SOME TESTS FAILED'}")
    
    return fib_success and prime_success
