import 'package:bloc/bloc.dart';
import 'package:ecommerce/Models/Login_Model.dart';
import 'package:ecommerce/Models/Registration_Model.dart';
import 'package:ecommerce/Repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final UserRepository userRepository = UserRepository();

  void register(String name, String phone, String email, String password)async {
    try {
      emit(LoadingAuthState());
      final response = await userRepository.registerNewUser(
          name, phone, email, password);
      final regRes = RegistraionResponseModel.fromJson(
          response.data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (regRes.status == true) {
        await prefs.setString('access-token', regRes.data?.token??'');
        emit(AuthSuccess());
      }
      else {
        emit(AuthNotValid(regRes.message!));
      }
      print(response);
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void login(String email , String password)async{
    try {
      final response = await userRepository.LoginUser(email, password);
      final log = LoginModel.fromJson(response.data);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (log.status == true) {
        await prefs.setString('access-token', log.data?.token??'');
        emit(AuthSuccess());
      }
      else {
        emit(AuthNotValid(log.message!));
      }
    }catch (e) {
      emit(AuthFailed(e.toString()));
    }

  }

}
