part of 'banner_cubit.dart';

@immutable
abstract class BannerState {}

 class BannerInitial extends BannerState {}
class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {
  final BannerModel banner_res;

  BannerSuccess(this.banner_res);
}
class BannerFailed extends BannerState {
  final String message;
  BannerFailed(this.message);
}