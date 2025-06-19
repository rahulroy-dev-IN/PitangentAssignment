abstract class ProductEvent {}

class LoadProduct extends ProductEvent {
  final String? category;
  LoadProduct({this.category});
}

class LoadMoreProduct extends ProductEvent {
  final String? category;
  LoadMoreProduct({this.category});
}
