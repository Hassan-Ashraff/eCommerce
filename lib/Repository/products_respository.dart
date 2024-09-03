import 'package:dio/dio.dart';
import 'package:ecommerce/Models/Products_Model.dart';

class ProductsRespository{

Future<ProductsModel> getProducts()async{
  final dio = Dio();
  final response = await dio.get('https://student.valuxapps.com/api/products?category_id');
  final products = ProductsModel.fromJson(response.data);
  return products;
}


}