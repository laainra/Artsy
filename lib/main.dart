import 'package:artsy_prj/routes.dart';
import 'package:flutter/material.dart';


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
