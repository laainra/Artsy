import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("Account"),
        centerTitle: true,
        leading: TextButton(
          child: Text(
            "<",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
          ),
          onPressed: () {
            // Fungsi untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Edit Profile", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Account Settings", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Saved Alerts", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Follows", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order History", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Push Notifications", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Send Feedback", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Personal Data Request", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.all(10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("EAbout", style: TextStyle(fontSize: 15),),
                Text(">"),
              ],
            ),
          ),
          Divider(),
                    ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => PaymentSuccessPage(
                  //             shipping: shipping,
                  //             artwork: artwork,
                  //             payment: payment,
                  //           )),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(350, 45),
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
        ],
      ),
    );
  }
}
