import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// CartProvider - Manages shopping cart state
///
/// This provider handles:
/// - Adding/removing items from cart
/// - Updating quantities
/// - Calculating totals
/// - Persisting cart data (future enhancement)
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  /// Get all cart items
  List<CartItem> get items => _items;

  /// Get total number of items in cart
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Get total price of all items in cart (USD)
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Get total price in Thai Baht
  double get totalPriceInBaht => totalPrice * 33;

  /// Check if a product is already in cart
  bool isInCart(Product product) {
    return _items.any((item) => item.product.id == product.id);
  }

  /// Get quantity of a specific product in cart
  int getQuantity(Product product) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    return existingItem.quantity;
  }

  /// Add item to cart or increase quantity if already exists
  void addItem(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Item already in cart, increase quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // Add new item to cart
      _items.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners();
  }

  /// Remove item from cart completely
  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  /// Update quantity of an item in cart
  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeItem(product);
      return;
    }

    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity = quantity;
      notifyListeners();
    }
  }

  /// Decrease quantity by 1, remove if quantity becomes 0
  void decreaseQuantity(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  /// Increase quantity by 1
  void increaseQuantity(Product product) {
    addItem(product, quantity: 1);
  }

  /// Clear all items from cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Get cart summary for display
  Map<String, dynamic> getCartSummary() {
    return {
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'totalPriceInBaht': totalPriceInBaht,
      'items': _items
          .map(
            (item) => {
              'title': item.product.title,
              'quantity': item.quantity,
              'price': item.totalPrice,
              'priceInBaht': item.totalPriceInBaht,
            },
          )
          .toList(),
    };
  }

  @override
  String toString() {
    return 'CartProvider(items: ${_items.length}, total: \$${totalPrice.toStringAsFixed(2)})';
  }
}
