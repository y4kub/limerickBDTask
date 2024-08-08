import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limeric_task/blocs/product/product_event.dart';
import 'package:limeric_task/blocs/product/product_state.dart';
import 'package:limeric_task/model/productModel.dart';

import '../../repos/productRepo.dart';
import '../../repos/userRepo.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final AuthRepository authRepository;
  final ProductRepository productRepository;
  List<ProductModel> _allProducts = [];

  ProductListBloc({required this.authRepository, required this.productRepository})
      : super(ProductListInitial()) {
    on<LoadProductList>(_onLoadProductList);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProductList(LoadProductList event, Emitter<ProductListState> emit) async {
    emit(ProductListLoading());
    try {
      final token = await authRepository.getToken();
      if (token != null) {
        final productList = await productRepository.fetchProductList(token);
        _allProducts = productList;
        print("All product bloc ${_allProducts.toString()}");
        emit(ProductListLoaded(productList: productList));
      } else {
        emit(ProductListError('No token found'));
      }
    } catch (error,stacktrace) {
      print('Error fetching product list: $error');
      print('Stacktrace: $stacktrace');
      emit(ProductListError(error.toString()));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<ProductListState> emit) {
    final query = event.query.toLowerCase();
    final filteredProducts = _allProducts
        .where((product) => product.name.toLowerCase().contains(query))
        .toList();
    emit(ProductListLoaded(productList: filteredProducts));
  }
}
