import 'package:ecommerce/Models/Fav_Model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}

class FavLoadingState extends FavState {}

class FavLoadedState extends FavState {
  final List<FavModel> items;

  FavLoadedState(this.items);
}

class FavErrorState extends FavState {
  final String message;

  FavErrorState(this.message);
}
