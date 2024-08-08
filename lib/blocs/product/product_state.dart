import 'package:limeric_task/model/productModel.dart';

abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductModel> productList;

  ProductListLoaded({required this.productList});
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);
}
