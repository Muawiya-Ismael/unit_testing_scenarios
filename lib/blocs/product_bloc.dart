
import 'package:unit_testing_scenarios/blocs/product_event.dart';
import 'package:unit_testing_scenarios/blocs/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _repository;

  ProductBloc(this._repository) : super(ProductLoading()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _repository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products'));
      }
    });

    on<ToggleFavorite>((event, emit) async {
      if (state is ProductLoaded) {
        final updatedProducts = (state as ProductLoaded).products.map((product) {
          if (product.id == event.product.id) {
            return product.copyWith(isFavorite: !product.isFavorite);
          }
          return product;
        }).toList();
        emit(ProductLoaded(updatedProducts));
        try {
          await _repository.toggleFavorite(event.product);
        } catch (e) {
          // Handle error, potentially revert state
        }
      }
    });
  }
}