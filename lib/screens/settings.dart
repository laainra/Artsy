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
        title: Text(
          "Account Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: TextButton(
          child: Text(
            "<",
            style: TextStyle(
              fontSize: 35,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-profileP');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Account Settings",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Saved Alerts",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Follows",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Order History",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Payment",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Push Notifications",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Send Feedback",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    " Personal Data Request",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "About",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/account-settings');
                  },
                ),
                Text(">"),
              ],
            ),
          ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
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
                borderRadius: BorderRadius.circular(35.0),
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
