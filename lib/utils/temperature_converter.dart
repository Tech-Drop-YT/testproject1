class TemperatureConverter {
  static double convert(double value, String from, String to) {
    if (from == to) return value;

    // First convert to Celsius as base unit
    double celsius;
    switch (from) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      case 'Rankine':
        celsius = (value - 491.67) * 5 / 9;
        break;
      case 'Reaumur':
        celsius = value * 5 / 4;
        break;
      default:
        celsius = value;
    }

    // Then convert from Celsius to target unit
    switch (to) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'Kelvin':
        return celsius + 273.15;
      case 'Rankine':
        return celsius * 9 / 5 + 491.67;
      case 'Reaumur':
        return celsius * 4 / 5;
      default:
        return celsius;
    }
  }

  static String getSymbol(String unit) {
    switch (unit) {
      case 'Celsius':
        return '°C';
      case 'Fahrenheit':
        return '°F';
      case 'Kelvin':
        return 'K';
      case 'Rankine':
        return 'R';
      case 'Reaumur':
        return '°Re';
      default:
        return '';
    }
  }
}
