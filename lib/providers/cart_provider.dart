import 'package:flutter/material.dart';
import '../models/story.dart';
import '../services/storage_service.dart';
import '../core/constants/app_constants.dart';

class CartProvider extends ChangeNotifier {
  final StorageService _storageService;
  final List<String> _cartIds = [];

  CartProvider(this._storageService) {
    _loadCart();
  }

  List<String> get cartIds => _cartIds;

  Future<void> _loadCart() async {
    final cart = await _storageService.getCart();
    _cartIds.clear();
    _cartIds.addAll(cart);
    notifyListeners();
  }

  bool isInCart(String storyId) {
    return _cartIds.contains(storyId);
  }

  Future<void> addToCart(Story story) async {
    if (!_cartIds.contains(story.id) && story.isPremium) {
      _cartIds.add(story.id);
      await _storageService.saveCart(_cartIds);
      notifyListeners();
    }
  }

  Future<void> removeFromCart(String storyId) async {
    _cartIds.remove(storyId);
    await _storageService.saveCart(_cartIds);
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cartIds.clear();
    await _storageService.saveCart(_cartIds);
    notifyListeners();
  }

  int get itemCount => _cartIds.length;

  double get totalPrice => _cartIds.length * AppConstants.premiumStoryPrice;

  String get formattedTotal => '\$${totalPrice.toStringAsFixed(2)}';
}
