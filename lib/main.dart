import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/routes.dart';
import 'package:flutter/material.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  // Initialize your database and other necessary setup
  final dbHelper = DBHelper();

  // Call the getAllUsers function
  List<UserModel> users = await dbHelper.getAllUsers();

  // Print the contents of each user
  for (UserModel user in users) {
    print('User ID: ${user.id}');
    print('Email: ${user.email}');
    print('Password: ${user.password}');
    // Add more fields if needed

    print('---'); // Separator between users
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artsy',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.black),
        fontFamily: 'assets/fonts/nunito.ttf',
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16.0,
            height: 1.5,
          ),
        ),
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
