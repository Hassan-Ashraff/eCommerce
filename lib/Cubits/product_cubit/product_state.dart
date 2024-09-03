part of 'product_cubit.dart';

@immutable
abstract class ProductState {}
class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductSuccess extends ProductState {
  final ProductsModel productsModel_res;

  ProductSuccess(this.productsModel_res);
}
class ProductFaildNotVaild extends ProductState {
  final String message;

  ProductFaildNotVaild(this.message);

}

