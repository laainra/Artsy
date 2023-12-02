import 'package:flutter/material.dart'; //
import 'package:artsy_prj/model/usermodel.dart'; //
import 'dart:async'; //
import 'package:artsy_prj/dbhelper.dart'; //

Future<List<UserModel>> fetchUserFromDatabase() async {
  //
  var dbHelper = DBHelper(); //
  var db = await dbHelper.database; //

  if (db != null) {
    //
    return dbHelper.getAllUsers(); //
  } else {
    //
    return []; //
  }
}

class UserListPage extends StatefulWidget {
  //
  @override //
  UserListPageState createState() => UserListPageState(); //
}

class UserListPageState extends State<UserListPage> {
  //
  late UserModel user = UserModel(name: '', email: ''); //
  final scaffoldKey = GlobalKey<ScaffoldState>(); //
  final formKey = GlobalKey<FormState>(); //
  late int id; //
  late String name; //
  late String email; //

  @override //
  Widget build(BuildContext context) {
    //
    return Scaffold(
      //
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        //
        title: Text(
          'User List',
          style: TextStyle(color: Colors.black),
        ), //
      ),
      body: Container(
        //
        padding: EdgeInsets.all(16.0), //
        child: FutureBuilder<List<UserModel>>(
          //
          future: fetchUserFromDatabase(), //
          builder: (context, snapshot) {
            //
            if (snapshot.connectionState == ConnectionState.waiting) {
              //
              return CircularProgressIndicator(); //
            } else if (snapshot.hasError) {
              //
              return Text("Error: ${snapshot.error}"); //
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //
              return Text("No data available"); //
            } else {
              //
              return ListView.builder(
                //
                itemCount: snapshot.data!.length, //
                itemBuilder: (context, index) {
                  //
                  var currentUser = snapshot.data![index]; //
                  return Card(
                      //
                      child: Container(
                    //
                    padding: EdgeInsets.all(2.0), //
                    margin: EdgeInsets.symmetric(vertical: 8.0), //
                    child: Row(
                      //
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, //
                      children: [
                        //
                        Column(
                          //
                          crossAxisAlignment: CrossAxisAlignment.start, //
                          children: [
                            //
                            Text(
                              //
                              currentUser.name ?? '', //
                              style: TextStyle(
                                //
                                fontSize: 18.0, //
                                fontWeight: FontWeight.bold, //
                              ),
                            ),
                            Text(
                              //
                              currentUser.email ?? '', //
                              style: TextStyle(
                                //
                                fontSize: 14.0, //
                                fontWeight: FontWeight.bold, //
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          //
                          icon: Icon(Icons.delete), //
                          onPressed: () {
                            //
                            showDeleteConfirmation(currentUser); //
                          },
                        ),
                      ],
                    ),
                  ));
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _deleteUser(int id) async {
    //
    if (id != null) {
      //
      var dbHelper = DBHelper(); //
      dbHelper.deleteUser(id); //
      _showSnackBar(context, "Data deleted successfully"); //
    } else {
      //
      _showSnackBar(context, "Error deleting data. Employee ID is null."); //
    }
    return Future.value(null); //
  }

  void handleDelete(UserModel user) async {
    //
    int id = user.id!; //
    await _deleteUser(id); //
    setState(() {}); //
  }

  void clearForm() {
    //
    formKey.currentState!.reset(); //
    setState(() {
      //
      user = UserModel(name: '', email: ''); //
    });
  }

  void _showSnackBar(BuildContext context, String text) {
    //
    ScaffoldMessenger.of(context).showSnackBar(
      //
      SnackBar(
        //
        content: Text(text), //
      ),
    );
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
          content: Text("Are you sure you want to delete this user?"), //
          actions: [
            //
            ElevatedButton(
              //
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
