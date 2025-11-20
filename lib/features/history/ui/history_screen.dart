import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/history_controller.dart';
import '../../calculator/controller/calculator_controller.dart';
import '../../../core/constants/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryController _historyController;

  @override
  void initState() {
    super.initState();
    _historyController = HistoryController();
    _historyController.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final calculatorController = context.read<CalculatorController>();

    return ChangeNotifierProvider.value(
      value: _historyController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          actions: [
            Consumer<HistoryController>(
              builder: (context, controller, child) {
                if (controller.isEmpty) return const SizedBox.shrink();

                return IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: () => _showClearConfirmation(context),
                  tooltip: 'Clear all',
                );
              },
            ),
          ],
        ),
        body: Consumer<HistoryController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.isEmpty) {
              return _buildEmptyState();
            }

            return _buildHistoryList(controller, calculatorController);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No History Yet',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your calculation history will appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(
    HistoryController controller,
    CalculatorController calculatorController,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.history.length,
      itemBuilder: (context, index) {
        final item = controller.history[index];
        final expression = item['expression'] ?? '';
        final result = item['result'] ?? '';
        final timestamp = item['timestamp'] ?? '';

        return _buildHistoryCard(
          context,
          expression,
          result,
          timestamp,
          index,
          controller,
          calculatorController,
        );
      },
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    String expression,
    String result,
    String timestamp,
    int index,
    HistoryController controller,
    CalculatorController calculatorController,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          calculatorController.loadExpression(expression);
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expression
                    Text(
                      expression,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isDark
                                ? AppColors.darkSecondaryText
                                : AppColors.lightSecondaryText,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Result
                    Text(
                      '= $result',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Timestamp
                    Text(
                      controller.formatTimestamp(timestamp),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),

              // Delete button
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: Colors.grey[600],
                onPressed: () => _showDeleteConfirmation(context, index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this calculation?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _historyController.deleteHistoryItem(index);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All History'),
        content: const Text('Are you sure you want to clear all calculation history?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _historyController.clearHistory();
              Navigator.pop(context);
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
