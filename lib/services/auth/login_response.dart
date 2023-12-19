import 'package:artsy_prj/services/auth/login_request.dart';
import 'package:artsy_prj/model/usermodel.dart';

abstract class LoginCallBack {
  void onLoginSuccess(UserModel user);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = LoginRequest();

  LoginResponse(this._callBack);

void doLogin(String email, String password) {
  loginRequest
      .getLogin(email, password)
      .then((user) {
        try {
          if (user != null) {
            _callBack.onLoginSuccess(user);
          } else {
            _callBack.onLoginError("User is null");
          }
        } catch (e) {
          _callBack.onLoginError("Error in onLoginSuccess: $e");
        }
      })
      .catchError((onError) {
        try {
          _callBack.onLoginError(onError.toString());
        } catch (e) {
          print("Error in onLoginError callback: $e");
        }
      });
}

}
