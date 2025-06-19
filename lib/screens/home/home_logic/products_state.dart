import 'package:pitangent_assignment/global/network/modal/remote/products_response.dart';

abstract class ProductsState {}

class ProductInitial extends ProductsState {}

class ProductInitialLoading extends ProductsState {}

class ProductLoading extends ProductsState {}

class ProductLoaded extends ProductsState {
  final List<ProductData> products;
  final bool hasReachedMax;

  ProductLoaded({required this.products, required this.hasReachedMax});

  ProductLoaded copyWith({List<ProductData>? products, bool? hasReachedMax}) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProductError extends ProductsState {
  final String message;
  ProductError(this.message);
}
