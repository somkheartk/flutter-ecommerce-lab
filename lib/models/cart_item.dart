import 'product.dart';

/// CartItem - Model representing an item in the shopping cart
///
/// This model contains:
/// - Product information
/// - Quantity of the product
/// - Helper methods for calculations
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  /// Calculate total price for this cart item
  double get totalPrice => product.price * quantity;

  /// Calculate total price in Thai Baht (conversion rate: 1 USD = 33 THB)
  double get totalPriceInBaht => totalPrice * 33;

  /// Create a copy of this cart item with updated quantity
  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }

  /// Create from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.product.id == product.id;
  }

  @override
  int get hashCode => product.id.hashCode;

  @override
  String toString() {
    return 'CartItem(product: ${product.title}, quantity: $quantity, total: \$${totalPrice.toStringAsFixed(2)})';
  }
}
