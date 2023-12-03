import 'dart:async';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/dbhelper.dart';

class LoginRequest {
  DBHelper con = DBHelper();

  Future<UserModel?> getLogin(String username, String password) async {
    try {
      var result = await con.getLogin(username, password);
      return result;
    } catch (e) {
      print("Error in getLogin: $e");
      return null;
    }
  }
}
