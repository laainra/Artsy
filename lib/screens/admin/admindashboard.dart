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
    ["Detail Artwork", "/detail-artwork"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, form[index][1]); // Fix here
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(form[index][0],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    )),
              ));
        },
        itemCount: form.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
