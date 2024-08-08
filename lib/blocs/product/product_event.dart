abstract class ProductListEvent {}

class LoadProductList extends ProductListEvent {}
class SearchProducts extends ProductListEvent {
  final String query;

  SearchProducts(this.query);
}