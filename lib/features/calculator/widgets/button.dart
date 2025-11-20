import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/colors.dart';

enum ButtonType { number, operator, equal, clear, special, function }

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isSmall;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.number,
    this.isSmall = false,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    HapticFeedback.lightImpact();
    widget.onPressed();
  }

  Color _getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.type) {
      case ButtonType.operator:
        return AppColors.primaryBlue;
      case ButtonType.equal:
        return AppColors.equalButton;
      case ButtonType.clear:
        return AppColors.clearButton;
      case ButtonType.special:
        return isDark ? AppColors.darkSpecialButton : AppColors.lightSpecialButton;
      case ButtonType.function:
        return isDark
            ? AppColors.darkButtonBg.withOpacity(0.8)
            : AppColors.lightButtonBg;
      case ButtonType.number:
      default:
        return isDark ? AppColors.numberButtonDark : AppColors.numberButton;
    }
  }

  Color _getTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.type) {
      case ButtonType.operator:
      case ButtonType.equal:
        return Colors.white;
      case ButtonType.clear:
        return Colors.white;
      case ButtonType.special:
        return AppColors.primaryBlue;
      case ButtonType.function:
        return isDark ? AppColors.darkText : AppColors.lightText;
      case ButtonType.number:
      default:
        return isDark ? AppColors.darkText : AppColors.lightText;
    }
  }

  double _getFontSize() {
    if (widget.isSmall) return 14;
    if (widget.text.length > 3) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: _getFontSize(),
                  fontWeight: FontWeight.w600,
                  color: _getTextColor(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
