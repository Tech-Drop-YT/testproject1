import 'package:flutter/foundation.dart';
import '../../../services/local_storage.dart';

class HistoryController with ChangeNotifier {
  List<Map<String, String>> _history = [];
  final LocalStorageService _storageService = LocalStorageService();
  bool _isLoading = false;

  List<Map<String, String>> get history => _history;
  bool get isLoading => _isLoading;
  bool get isEmpty => _history.isEmpty;

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _history = await _storageService.getHistory();
    } catch (e) {
      _history = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await _storageService.clearHistory();
    _history = [];
    notifyListeners();
  }

  Future<void> deleteHistoryItem(int index) async {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      await _storageService.saveHistory(_history);
      notifyListeners();
    }
  }

  String formatTimestamp(String timestamp) {
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }
}
