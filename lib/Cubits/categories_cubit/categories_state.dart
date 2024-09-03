part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}
class CategoriesLoading extends CategoriesState {}
class CategoriesSuccess extends CategoriesState {
  final CategoriesModel categories_res;

  CategoriesSuccess(this.categories_res);
}
class CategoriesFaildNotVaild extends CategoriesState {
  final String message;

  CategoriesFaildNotVaild(this.message);
}



