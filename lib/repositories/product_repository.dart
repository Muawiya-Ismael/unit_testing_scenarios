import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
  Future<void> toggleFavorite(Product product);
}