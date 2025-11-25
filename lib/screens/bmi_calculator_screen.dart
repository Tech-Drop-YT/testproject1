import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _bmi;
  String _category = '';
  Color _categoryColor = Colors.grey;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight == null || height == null || height == 0) {
      return;
    }

    // Convert height from cm to m
    final heightInMeters = height / 100;
    final bmi = weight / (heightInMeters * heightInMeters);

    setState(() {
      _bmi = bmi;
      _categorize(bmi);
    });

    _animationController.reset();
    _animationController.forward();
  }

  void _categorize(double bmi) {
    if (bmi < 18.5) {
      _category = 'Underweight';
      _categoryColor = const Color(0xFF3B82F6); // Blue
    } else if (bmi >= 18.5 && bmi < 25) {
      _category = 'Normal';
      _categoryColor = const Color(0xFF10B981); // Green
    } else if (bmi >= 25 && bmi < 30) {
      _category = 'Overweight';
      _categoryColor = const Color(0xFFF59E0B); // Orange
    } else {
      _category = 'Obesity';
      _categoryColor = const Color(0xFFEF4444); // Red
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = const Color(0xFFD81B60);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calculate Your BMI',
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Body Mass Index calculator',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Weight Input
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.monitor_weight_rounded,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Weight',
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: theme.textTheme.headlineMedium,
                        decoration: InputDecoration(
                          hintText: '0',
                          suffixText: 'kg',
                          suffixStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (_) => _calculateBMI(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Height Input
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.height_rounded,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Height',
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: theme.textTheme.headlineMedium,
                        decoration: InputDecoration(
                          hintText: '0',
                          suffixText: 'cm',
                          suffixStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (_) => _calculateBMI(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Result
              if (_bmi != null)
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Card(
                    color: _categoryColor.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: _categoryColor, width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Text(
                            'Your BMI',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: _categoryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _bmi!.toStringAsFixed(1),
                            style: theme.textTheme.displayLarge?.copyWith(
                              color: _categoryColor,
                              fontSize: 64,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: _categoryColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              _category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 32),

              // BMI Categories Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: primaryColor),
                          const SizedBox(width: 12),
                          Text(
                            'BMI Categories',
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildCategoryRow(
                        'Underweight',
                        '< 18.5',
                        const Color(0xFF3B82F6),
                        theme,
                      ),
                      _buildCategoryRow(
                        'Normal',
                        '18.5 - 24.9',
                        const Color(0xFF10B981),
                        theme,
                      ),
                      _buildCategoryRow(
                        'Overweight',
                        '25.0 - 29.9',
                        const Color(0xFFF59E0B),
                        theme,
                      ),
                      _buildCategoryRow(
                        'Obesity',
                        '≥ 30.0',
                        const Color(0xFFEF4444),
                        theme,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(
    String category,
    String range,
    Color color,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              category,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            range,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
