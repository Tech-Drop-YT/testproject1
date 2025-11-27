// FILE: lib/src/ui/widgets/token_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/models.dart';
import '../../utils/constants.dart';

/// Widget for displaying a game token
class TokenWidget extends StatelessWidget {
  final Token token;
  final bool isSelected;
  final bool isHighlighted;
  final VoidCallback? onTap;
  final double size;

  const TokenWidget({
    Key? key,
    required this.token,
    this.isSelected = false,
    this.isHighlighted = false,
    this.onTap,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = GameConstants.playerColors[token.color] ?? Colors.grey;
    final lightColor = GameConstants.playerLightColors[token.color] ?? Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              lightColor,
              color,
            ],
          ),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.white,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: isHighlighted ? 12 : 6,
              spreadRadius: isHighlighted ? 2 : 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${token.tokenIndex + 1}',
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
          .animate(
            onPlay: (controller) => isHighlighted ? controller.repeat() : null,
          )
          .shimmer(
            duration: const Duration(milliseconds: 1000),
            color: isHighlighted ? Colors.amber.withOpacity(0.3) : Colors.transparent,
          )
          .scale(
            duration: const Duration(milliseconds: 200),
            begin: const Offset(1.0, 1.0),
            end: isSelected ? const Offset(1.1, 1.1) : const Offset(1.0, 1.0),
          ),
    );
  }
}

/// Widget for kill animation
class TokenKillAnimation extends StatelessWidget {
  final Token token;
  final VoidCallback? onComplete;

  const TokenKillAnimation({
    Key? key,
    required this.token,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TokenWidget(
      token: token,
      size: 40,
    )
        .animate(onComplete: (controller) => onComplete?.call())
        .shake(duration: const Duration(milliseconds: 300))
        .fadeOut(duration: const Duration(milliseconds: 500))
        .scale(
          duration: const Duration(milliseconds: 500),
          end: const Offset(0.5, 0.5),
        );
  }
}
