import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  AdminDashboardPage({Key? key}) : super(key: key);
  final List<List<String>> form = [
    ["Artist List", "/artist-list"],
    ["Artwork List", "/artwork-list"],
    ["Auction List", "/auction-list"],
    ["Editorial List", "/editorial-list"],
    ["Gallery List", "/gallery-list"],
    ["Show List", "/show-list"],
    ["Transaction List", "/transaction-list"],
    ["User List", "/user-list"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Admin Dashboard",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return TextButton(
            onPressed: () {
              Navigator.pushNamed(context, form[index][1]); // Fix here
            },
            child: Text(form[index][0], style: TextStyle(fontSize: 20)),
            
          );
        },
        itemCount: form.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
