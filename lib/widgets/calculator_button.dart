import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isWide = false,
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBgColor = isDark
        ? const Color(0xFF1A1F2E)
        : const Color(0xFFFFFFFF);
    final defaultTextColor = isDark
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF1A1A1A);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _controller.forward().then((_) => _controller.reverse());
              widget.onPressed();
            },
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? defaultBgColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (widget.backgroundColor ?? defaultBgColor)
                        .withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                width: widget.isWide ? double.infinity : null,
                height: 64,
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: widget.fontSize ?? 24,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor ?? defaultTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
