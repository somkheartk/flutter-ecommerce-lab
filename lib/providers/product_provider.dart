import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

/// ProductProvider manages product data and state
///
/// This provider fetches products from API and notifies listeners
/// when data changes
class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  final ApiService _apiService = ApiService();

  // Getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetch all products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get products by category
  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  /// Get a single product by ID
  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get all unique categories
  List<String> getCategories() {
    return _products.map((product) => product.category).toSet().toList();
  }
}
