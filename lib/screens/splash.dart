import 'dart:async';

import 'package:flutter/material.dart';
import 'package:artsy_prj/screens/landing.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({ Key? key }) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {

    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {

    var durasiSplash = const Duration(seconds: 2);

    return Timer(durasiSplash, () {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return LandingPage();
        })
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 200,
          height: 88,
        ),
      ),
    );
  }
}