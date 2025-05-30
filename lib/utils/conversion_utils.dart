class ConversionUtils {
  /// Converts Celsius temperature to Fahrenheit.
  /// Formula: (°C × 9/5) + 32 = °F
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  /// Converts Fahrenheit temperature to Celsius.
  /// Formula: (°F - 32) × 5/9 = °C
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  /// Formats a temperature value to display with one decimal place.
  /// Returns the temperature as a string with fixed-point notation.
  static String formatTemperature(double temp) {
    return temp.toStringAsFixed(1);
  }
}