// FILE: lib/src/models/dice_result.dart

/// Represents the result of rolling two dice
class DiceResult {
  final int dice1;
  final int dice2;
  final DateTime timestamp;

  const DiceResult({
    required this.dice1,
    required this.dice2,
    required this.timestamp,
  });

  /// Get the sum of both dice
  int get sum => dice1 + dice2;

  /// Check if both dice show the same value
  bool get isDouble => dice1 == dice2;

  /// Check if it's a single 6
  bool get isSingleSix => (dice1 == 6 && dice2 != 6) || (dice2 == 6 && dice1 != 6);

  /// Check if it's a double 6
  bool get isDoubleSix => dice1 == 6 && dice2 == 6;

  /// Check if either die shows a 6
  bool get hasAnySix => dice1 == 6 || dice2 == 6;

  /// Get list of individual dice values
  List<int> get values => [dice1, dice2];

  /// Get all possible move combinations
  /// Returns: [sum, dice1, dice2] for movement options
  List<int> get moveOptions => [sum, dice1, dice2];

  @override
  String toString() => 'DiceResult(dice1: $dice1, dice2: $dice2, sum: $sum)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiceResult &&
        other.dice1 == dice1 &&
        other.dice2 == dice2;
  }

  @override
  int get hashCode => dice1.hashCode ^ dice2.hashCode;

  /// Create a copy with optional new values
  DiceResult copyWith({
    int? dice1,
    int? dice2,
    DateTime? timestamp,
  }) {
    return DiceResult(
      dice1: dice1 ?? this.dice1,
      dice2: dice2 ?? this.dice2,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'dice1': dice1,
      'dice2': dice2,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create from JSON
  factory DiceResult.fromJson(Map<String, dynamic> json) {
    return DiceResult(
      dice1: json['dice1'] as int,
      dice2: json['dice2'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
