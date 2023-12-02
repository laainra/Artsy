import 'package:flutter/material.dart';
import 'package:artsy_prj/components/home/new_works_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your logo asset path
          height: 30, // Adjust the height as needed
        ),
        actions: [
          IconButton(
            icon: Icon(
              weight: 100,
              Icons.notifications_outlined,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              // Tindakan yang diambil saat ikon notifikasi ditekan
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return NewWorksSection();
            },
          )),
    );
  }
}
