import '../models/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class ToggleFavorite extends ProductEvent {
  final Product product;
  ToggleFavorite(this.product);
}