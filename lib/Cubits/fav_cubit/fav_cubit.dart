import 'package:bloc/bloc.dart';
import 'package:ecommerce/Models/Fav_Model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fav_state.dart'; // Ensure this import is correct

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  final List<FavModel> _items = [];

  void addItemToFav(FavModel item)async {
    try {

      emit(FavLoadingState());
      _items.add(item);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      emit(FavLoadedState(List.from(_items)));
    } catch (e) {
      emit(FavErrorState("Failed to add item to favorites."));
    }
  }

  void removeItemFromFav(FavModel item) {
    try {
      emit(FavLoadingState());
      _items.remove(item);
      emit(FavLoadedState(List.from(_items)));
    } catch (e) {
      emit(FavErrorState("Failed to remove item from favorites."));
    }
  }

  List<FavModel> get items => _items;
}
