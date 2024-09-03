import 'package:bloc/bloc.dart';
import 'package:ecommerce/Models/Banner_Model.dart';
import 'package:ecommerce/Repository/banner_respository.dart';
import 'package:meta/meta.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
final BannerRespository bannerRespository;
  BannerCubit(this.bannerRespository) : super(BannerInitial());

  Future<void> getBannersItem()async{
    try {
      emit(BannerLoading());
      final bannersItem = await bannerRespository.getBanner();
      if(bannersItem.status == true){
        emit(BannerSuccess(bannersItem));
      }
      else
        {
          emit(BannerFailed(bannersItem.message));
        }
    } catch (e) {
      emit(BannerFailed(e.toString()));

    }

  }

}
