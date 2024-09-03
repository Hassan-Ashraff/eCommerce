import 'package:bloc/bloc.dart';
import 'package:ecommerce/Models/Products_Model.dart';
import 'package:ecommerce/Repository/products_respository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
final ProductsRespository productsRespository;
  ProductCubit(this.productsRespository) : super(ProductInitial());
  Future<void> Products()async{
    try {
      final product = await productsRespository.getProducts();
      emit(ProductLoading());
      if(product.status == true)
        {
         emit(ProductSuccess(product));
        }
      else
        {
          emit(ProductFaildNotVaild(product.message));
        }
    } catch (e) {
      emit(ProductFaildNotVaild(e.toString()));
    }


  }

}
