import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  final UserModel user;

  const AccountSettings({Key? key, required this.user}) : super(key: key);
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
                    Text(widget.user.email!,
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
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 30,
              child: Text(
                "LINKED ACCOUNTS",
                textAlign: TextAlign.start,
              )),
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
                showDeleteConfirmation(widget.user);
              },
              child: Text(
                "Delete My Acoount",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }

  void handleDelete(UserModel user) async {
    //
    int id = user.id!; //
    var dbHelper = DBHelper(); //
    dbHelper.deleteUser(id); //
    setState(() {}); //
  }

  void showDeleteConfirmation(UserModel user) {
    //
    showDialog(
      //
      context: context, //
      builder: (BuildContext context) {
        //
        return AlertDialog(
          //
          title: Text("Delete User"), //
          content: Text("Are you sure you want to delete this account?"), //
          actions: [
            //
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                // Add a margin of 20 to all edges
              ),
              onPressed: () {
                //
                handleDelete(user); //
                Navigator.pop(context); //
              },
              child: Text('Delete'), //
            ),
            TextButton(
              //
              onPressed: () {
                //
                Navigator.pop(context); //
              },
              child: Text('Cancel'), //
            ),
          ],
        );
      },
    );
  }
}
