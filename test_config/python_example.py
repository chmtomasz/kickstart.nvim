#!/usr/bin/env python3
"""
Example Python file to demonstrate development features.
"""

import math
from typing import List, Optional


class Calculator:
    """A simple calculator class for demonstration."""
    
    def __init__(self, precision: int = 2):
        """Initialize the calculator.
        
        Args:
            precision: Number of decimal places for results
        """
        self.precision = precision
        self.history: List[str] = []
    
    def add(self, a: float, b: float) -> float:
        """Add two numbers.
        
        Args:
            a: First number
            b: Second number
            
        Returns:
            Sum of a and b
        """
        result = round(a + b, self.precision)
        self.history.append(f"{a} + {b} = {result}")
        return result
    
    def multiply(self, a: float, b: float) -> float:
        """Multiply two numbers."""
        result = round(a * b, self.precision)
        self.history.append(f"{a} * {b} = {result}")
        return result
    
    def sqrt(self, x: float) -> Optional[float]:
        """Calculate square root."""
        if x < 0:
            return None
        result = round(math.sqrt(x), self.precision)
        self.history.append(f"√{x} = {result}")
        return result
    
    def get_history(self) -> List[str]:
        """Get calculation history."""
        return self.history.copy()


def main():
    """Main function to demonstrate the calculator."""
    calc = Calculator(precision=3)
    
    # Perform some calculations
    print("Calculator Demo")
    print("=" * 20)
    
    result1 = calc.add(10.5, 5.25)
    print(f"Addition: {result1}")
    
    result2 = calc.multiply(3.14159, 2)
    print(f"Multiplication: {result2}")
    
    result3 = calc.sqrt(16)
    print(f"Square root: {result3}")
    
    # Try invalid input
    result4 = calc.sqrt(-1)
    print(f"Invalid sqrt: {result4}")
    
    # Show history
    print("\nCalculation History:")
    for entry in calc.get_history():
        print(f"  {entry}")


if __name__ == "__main__":
    main()