import 'package:artsy_prj/screens/admin/gallerylist.dart';
import 'package:flutter/material.dart';
import 'package:artsy_prj/screens/splash.dart';
import 'package:artsy_prj/screens/login.dart';
import 'package:artsy_prj/screens/register.dart';
import 'package:artsy_prj/screens/formlogin.dart';
import 'package:artsy_prj/screens/formregister.dart';
import 'package:artsy_prj/screens/home.dart';
import 'package:artsy_prj/screens/admin/admindashboard.dart';
import 'package:artsy_prj/screens/admin/userlist.dart';
import 'package:artsy_prj/screens/admin/artistlist.dart';
import 'package:artsy_prj/screens/admin/artworklist.dart';

void main() {
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
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreenPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/login_form': (context) => LoginFormPage(),
        '/register_form': (context) => EmailPage(),
        '/home': (context) => HomePage(),
        '/admin_dashboard': (context) => AdminDashboardPage(),
        '/artist-list': (context) => ArtistList(),
        '/user-list': (context) => UserListPage(),
        '/artwork-list': (context) => ArtworkListPage(),
        '/gallery-list': (context) => GalleryListPage(),
      },
    );
  }
}
