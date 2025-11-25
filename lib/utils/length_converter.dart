class LengthConverter {
  static double convert(double value, String from, String to) {
    if (from == to) return value;

    // First convert to meters as base unit
    double meters;
    switch (from) {
      case 'Meter':
        meters = value;
        break;
      case 'Centimeter':
        meters = value / 100;
        break;
      case 'Millimeter':
        meters = value / 1000;
        break;
      case 'Kilometer':
        meters = value * 1000;
        break;
      case 'Inch':
        meters = value * 0.0254;
        break;
      case 'Foot':
        meters = value * 0.3048;
        break;
      case 'Yard':
        meters = value * 0.9144;
        break;
      case 'Mile':
        meters = value * 1609.344;
        break;
      case 'Nautical Mile':
        meters = value * 1852;
        break;
      default:
        meters = value;
    }

    // Then convert from meters to target unit
    switch (to) {
      case 'Meter':
        return meters;
      case 'Centimeter':
        return meters * 100;
      case 'Millimeter':
        return meters * 1000;
      case 'Kilometer':
        return meters / 1000;
      case 'Inch':
        return meters / 0.0254;
      case 'Foot':
        return meters / 0.3048;
      case 'Yard':
        return meters / 0.9144;
      case 'Mile':
        return meters / 1609.344;
      case 'Nautical Mile':
        return meters / 1852;
      default:
        return meters;
    }
  }

  static String getSymbol(String unit) {
    switch (unit) {
      case 'Meter':
        return 'm';
      case 'Centimeter':
        return 'cm';
      case 'Millimeter':
        return 'mm';
      case 'Kilometer':
        return 'km';
      case 'Inch':
        return 'in';
      case 'Foot':
        return 'ft';
      case 'Yard':
        return 'yd';
      case 'Mile':
        return 'mi';
      case 'Nautical Mile':
        return 'nmi';
      default:
        return '';
    }
  }

  static String getDescription(String unit) {
    switch (unit) {
      case 'Meter':
        return 'SI base unit of length';
      case 'Centimeter':
        return '1/100 of a meter';
      case 'Millimeter':
        return '1/1000 of a meter';
      case 'Kilometer':
        return '1000 meters';
      case 'Inch':
        return 'Imperial unit, 2.54 cm';
      case 'Foot':
        return 'Imperial unit, 12 inches';
      case 'Yard':
        return 'Imperial unit, 3 feet';
      case 'Mile':
        return 'Imperial unit, 5280 feet';
      case 'Nautical Mile':
        return 'Maritime unit, 1852 meters';
      default:
        return '';
    }
  }
}
