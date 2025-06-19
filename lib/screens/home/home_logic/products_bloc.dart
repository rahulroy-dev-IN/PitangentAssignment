import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitangent_assignment/global/di/dependency_injection.dart';
import 'package:pitangent_assignment/global/network/app_repo/app_repository.dart';
import 'package:pitangent_assignment/global/network/handle_error.dart';

import 'product_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductsState> {
  int skip = 0;
  final int limit = 30;
  bool isFetching = false;

  ProductsBloc() : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      skip = 0;
      emit(ProductInitialLoading());
      try {
        final product = await getIt<AppRepository>().fetchProduct(
          skip: skip,
          limit: limit,
          category: event.category,
        );
        emit(
          ProductLoaded(
            products: product.products ?? [],
            hasReachedMax: (product.products?.length ?? 0) < limit,
          ),
        );
      } catch (e) {
        final errorMessage = handleDioError(e);
        emit(ProductError(errorMessage));
      }
    });

    on<LoadMoreProduct>((event, emit) async {
      if (state is ProductLoaded && !isFetching) {
        final currentState = state as ProductLoaded;
        if (currentState.hasReachedMax) return;

        isFetching = true;
        skip += limit;
        try {
          final res = await getIt<AppRepository>().fetchProduct(
            skip: skip,
            limit: limit,
          );
          emit(
            (res.products?.isEmpty ?? true)
                ? currentState.copyWith(hasReachedMax: true)
                : ProductLoaded(
                    products: currentState.products + res.products!,
                    hasReachedMax: (res.products?.length ?? 0) < limit,
                  ),
          );
        } catch (e) {
          //do nothing
        }
        isFetching = false;
      }
    });
  }
}
