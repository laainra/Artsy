import 'dart:async';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/dbhelper.dart';

class LoginRequest {
  DBHelper con = DBHelper();

Future<UserModel?> getLogin( String email, String password) async {
   DBHelper con = DBHelper();
  try {
    
    var result = await con.getLogin(email, password);

    return result;
  } catch (e) {
    // Handle exceptions here, such as printing an error message or logging
    print("Error in getLogin: $e");
    return null; // Return null or handle the error according to your needs
  }
}

}
