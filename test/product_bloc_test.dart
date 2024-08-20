import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_scenarios/blocs/product_bloc.dart';
import 'package:unit_testing_scenarios/blocs/product_event.dart';
import 'package:unit_testing_scenarios/blocs/product_state.dart';
import 'package:unit_testing_scenarios/models/product.dart';
import 'package:unit_testing_scenarios/repositories/product_repository.dart';


import 'product_bloc_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  group('ProductBloc', () {
    late MockProductRepository mockRepository;
    late ProductBloc bloc;

    setUp(() {
      mockRepository = MockProductRepository();
      bloc = ProductBloc(mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is ProductLoading', () {
      expect(bloc.state, isA<ProductLoading>());
    });

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when LoadProducts is added',
      build: () {
        when(mockRepository.fetchProducts())
            .thenAnswer((_) async => [
          Product(id: 1, name: 'Product 1', price: 10.0),
          Product(id: 2, name: 'Product 2', price: 15.0),
        ]);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadProducts()),
      expect: () => [
        isA<ProductLoading>(),
        isA<ProductLoaded>(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductError] when fetching products fails',
      build: () {
        when(mockRepository.fetchProducts()).thenThrow(Exception('Error'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadProducts()),
      expect: () => [
        isA<ProductLoading>(),
        isA<ProductError>(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits updated ProductLoaded state when ToggleFavorite is added',
      build: () {
        when(mockRepository.fetchProducts())
            .thenAnswer((_) async => [
          Product(id: 1, name: 'Product 1', price: 10.0),
        ]);
        when(mockRepository.toggleFavorite(any)).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(LoadProducts());
        await Future.delayed(Duration.zero);
        bloc.add(ToggleFavorite(Product(id: 1, name: 'Product 1', price: 10.0)));
      },
      expect: () => [
        isA<ProductLoading>(),
        isA<ProductLoaded>(),
        isA<ProductLoaded>(),
      ],
      verify: (bloc) {
        verify(mockRepository.toggleFavorite(any)).called(1);
      },
    );
  });
}