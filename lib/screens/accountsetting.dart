import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text('account@gmail.com',
                        style: TextStyle(
                            color: Colors
                                .grey)), // place actual account from database
                    SizedBox(
                      width: 5,
                    ),
                    Text(">", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text('Add phone',
                        style: TextStyle(
                            color: Colors
                                .grey)), // place actual account from database
                    SizedBox(
                      width: 5,
                    ),
                    Text(">", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price Range",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text('No budget in mind',
                        style: TextStyle(
                            color: Colors
                                .grey)), // place actual account from database
                    SizedBox(
                      width: 5,
                    ),
                    Text(">", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Password",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text('Change password',
                        style: TextStyle(
                            color: Colors
                                .grey)), // place actual account from database
                    SizedBox(
                      width: 5,
                    ),
                    Text(">", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 30,
              child: Text("LINKED ACCOUNTS")),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Facebook",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/facebook_logo.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Link", style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(">", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Google",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/google_logo.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Link", style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(">", style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                //
              },
              child: Text(
                "Delete My Acoount",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }
}
