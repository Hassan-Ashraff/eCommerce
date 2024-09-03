import 'package:dio/dio.dart';
import 'package:ecommerce/Models/Categories_Model.dart';
import 'package:ecommerce/Repository/banner_respository.dart';

class CategoriesRespository{
  Future<CategoriesModel> getCategories()async{
    final dio = Dio();
   final response = await dio.get('https://student.valuxapps.com/api/categories');
   final categories = CategoriesModel.fromJson(response.data);
   return categories;
  }

}