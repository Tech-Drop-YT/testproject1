// FILE: lib/src/ui/widgets/dice_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget for displaying a single die
class DiceWidget extends StatelessWidget {
  final int value;
  final bool isRolling;
  final VoidCallback? onTap;
  final double size;
  final Color color;

  const DiceWidget({
    Key? key,
    required this.value,
    this.isRolling = false,
    this.onTap,
    this.size = 60,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? Colors.white24 : Colors.black12,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: _buildDots(value, isDark),
        ),
      )
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(
            duration: const Duration(milliseconds: 1000),
            color: isRolling ? Colors.amber.withOpacity(0.5) : Colors.transparent,
          )
          .shake(
            hz: isRolling ? 4 : 0,
            duration: const Duration(milliseconds: 500),
          ),
    );
  }

  Widget _buildDots(int value, bool isDark) {
    final dotColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _getDicePattern(value, dotColor),
    );
  }

  Widget _getDicePattern(int value, Color dotColor) {
    switch (value) {
      case 1:
        return _buildPattern([
          [0, 0, 0],
          [0, 1, 0],
          [0, 0, 0],
        ], dotColor);
      case 2:
        return _buildPattern([
          [1, 0, 0],
          [0, 0, 0],
          [0, 0, 1],
        ], dotColor);
      case 3:
        return _buildPattern([
          [1, 0, 0],
          [0, 1, 0],
          [0, 0, 1],
        ], dotColor);
      case 4:
        return _buildPattern([
          [1, 0, 1],
          [0, 0, 0],
          [1, 0, 1],
        ], dotColor);
      case 5:
        return _buildPattern([
          [1, 0, 1],
          [0, 1, 0],
          [1, 0, 1],
        ], dotColor);
      case 6:
        return _buildPattern([
          [1, 0, 1],
          [1, 0, 1],
          [1, 0, 1],
        ], dotColor);
      default:
        return Container();
    }
  }

  Widget _buildPattern(List<List<int>> pattern, Color dotColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pattern.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((dot) {
            return dot == 1
                ? Container(
                    width: size * 0.15,
                    height: size * 0.15,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  )
                : SizedBox(width: size * 0.15, height: size * 0.15);
          }).toList(),
        );
      }).toList(),
    );
  }
}

/// Widget for displaying both dice with roll button
class DualDiceWidget extends StatelessWidget {
  final int dice1Value;
  final int dice2Value;
  final bool isRolling;
  final VoidCallback? onRoll;
  final bool enabled;

  const DualDiceWidget({
    Key? key,
    required this.dice1Value,
    required this.dice2Value,
    this.isRolling = false,
    this.onRoll,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DiceWidget(
              value: dice1Value,
              isRolling: isRolling,
              onTap: enabled ? onRoll : null,
            ),
            const SizedBox(width: 20),
            DiceWidget(
              value: dice2Value,
              isRolling: isRolling,
              onTap: enabled ? onRoll : null,
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: enabled && !isRolling ? onRoll : null,
          icon: const Icon(Icons.casino),
          label: Text(isRolling ? 'ROLLING...' : 'ROLL DICE'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
