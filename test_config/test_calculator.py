"""
Test file for the Calculator class.
Run with: pytest test_calculator.py
"""

import pytest
import sys
import os

# Add the test_config directory to the path
sys.path.insert(0, os.path.dirname(__file__))

from python_example import Calculator


class TestCalculator:
    """Test cases for Calculator class."""
    
    def test_calculator_init(self):
        """Test calculator initialization."""
        calc = Calculator()
        assert calc.precision == 2
        assert calc.history == []
        
        calc_custom = Calculator(precision=5)
        assert calc_custom.precision == 5
    
    def test_add(self):
        """Test addition functionality."""
        calc = Calculator()
        result = calc.add(5, 3)
        assert result == 8.0
        assert len(calc.history) == 1
        assert "5 + 3 = 8.0" in calc.history[0]
    
    def test_multiply(self):
        """Test multiplication functionality."""
        calc = Calculator()
        result = calc.multiply(4, 2.5)
        assert result == 10.0
        assert len(calc.history) == 1
    
    def test_sqrt_positive(self):
        """Test square root with positive number."""
        calc = Calculator()
        result = calc.sqrt(9)
        assert result == 3.0
        assert len(calc.history) == 1
    
    def test_sqrt_negative(self):
        """Test square root with negative number."""
        calc = Calculator()
        result = calc.sqrt(-1)
        assert result is None
        assert len(calc.history) == 0
    
    def test_precision(self):
        """Test precision setting."""
        calc = Calculator(precision=1)
        result = calc.add(1.111, 2.222)
        assert result == 3.3
    
    def test_history(self):
        """Test calculation history."""
        calc = Calculator()
        calc.add(1, 2)
        calc.multiply(3, 4)
        
        history = calc.get_history()
        assert len(history) == 2
        assert "1 + 2 = 3.0" in history[0]
        assert "3 * 4 = 12.0" in history[1]
    
    @pytest.mark.parametrize("a,b,expected", [
        (0, 0, 0),
        (1, 1, 2),
        (-1, 1, 0),
        (0.5, 0.5, 1.0),
    ])
    def test_add_parametrized(self, a, b, expected):
        """Parametrized test for addition."""
        calc = Calculator()
        result = calc.add(a, b)
        assert result == expected


# Fixtures for more complex testing
@pytest.fixture
def calculator():
    """Fixture providing a Calculator instance."""
    return Calculator(precision=2)


@pytest.fixture
def calculator_with_history(calculator):
    """Fixture providing a Calculator with some history."""
    calculator.add(1, 2)
    calculator.multiply(3, 4)
    return calculator


def test_with_fixture(calculator):
    """Test using calculator fixture."""
    result = calculator.sqrt(25)
    assert result == 5.0


def test_history_fixture(calculator_with_history):
    """Test using calculator with history fixture."""
    history = calculator_with_history.get_history()
    assert len(history) == 2