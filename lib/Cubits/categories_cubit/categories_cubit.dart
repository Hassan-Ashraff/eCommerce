import 'package:bloc/bloc.dart';
import 'package:ecommerce/Models/Categories_Model.dart';
import 'package:ecommerce/Repository/categories_respository.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final  CategoriesRespository categoriesRespository;
  CategoriesCubit(this.categoriesRespository) : super(CategoriesInitial());


  Future<void> Categories_Items() async {
    try {
    emit(CategoriesLoading());
    final categories = await categoriesRespository.getCategories();
          if(categories.status == true){
            emit(CategoriesSuccess(categories));
          }
          else{
            emit(CategoriesFaildNotVaild(categories.message));
          }
        }catch (e) {
          emit(CategoriesFaildNotVaild(e.toString()));
        }


  }
}