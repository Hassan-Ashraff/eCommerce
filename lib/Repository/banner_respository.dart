import 'package:dio/dio.dart';
import 'package:ecommerce/Models/Banner_Model.dart';
class BannerRespository {
  final Dio dio =
  Dio(BaseOptions(baseUrl: 'https://student.valuxapps.com/api/'));

  Future<BannerModel> getBanner() async {
    final response = await dio.get('banners');
    final banner = BannerModel.fromJson(response.data);
    return banner;
  }
}
