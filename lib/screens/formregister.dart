import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart'; // Import package email_validator
import 'package:artsy_prj/screens/home.dart';
import 'package:artsy_prj/dbhelper.dart';
import 'package:artsy_prj/model/usermodel.dart';
import 'package:artsy_prj/screens/admin/admindashboard.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController emailController = TextEditingController();
  bool isEmailEmpty = false;
  bool isEmailValid = true;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign Up with Email",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 50),
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  isEmailEmpty = value.isEmpty;
                  isEmailValid = EmailValidator.validate(value);
                });
              },
              decoration: InputDecoration(
                hintText: "Email Address",
                hintStyle: TextStyle(color: Colors.grey),
                errorText: isEmailEmpty
                    ? "Email field is required"
                    : (isEmailValid
                        ? null
                        : "Please provide a valid email address"),
                fillColor: Colors.white,
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 151, 141, 141)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: isEmailEmpty
                    ? null
                    : IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            emailController.clear();
                          });
                        },
                      ),
              ),
            ),
            SizedBox(height: 16),
            if (errorMessage.isNotEmpty)
              Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (!isEmailEmpty && isEmailValid) {
                    // Create a UserModel object with email
                    UserModel user = UserModel(email: emailController.text);

                    // Navigate to the PasswordPage and pass the user object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordPage(user: user)),
                    );
                  } else {
                    setState(() {
                      errorMessage = 'Please fill in all fields.';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  minimumSize: Size(350, 45),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordPage extends StatefulWidget {
  final UserModel user;

  PasswordPage({required this.user});
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController passwordController = TextEditingController();
  bool isPasswordEmpty = false;
  bool isPasswordValid = true;
  bool isPasswordVisible = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
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
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Create a Password",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Text(
                    "Password must be at least 8 characters and include a lowercase letter, uppercase letter, and digit",
                    style: TextStyle(fontSize: 13.5),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      isPasswordEmpty = value.isEmpty;
                      isPasswordValid = value.isValid;
                    });
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Password",
                    errorText:
                        isPasswordEmpty ? "Password field is required" : null,
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 151, 141, 141)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: isPasswordEmpty
                        ? null
                        : IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              if (errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (!isPasswordEmpty && isPasswordValid) {
                      // Update the existing user object with the password
                      widget.user.password = passwordController.text;

                      // Navigate to the NamePage and pass the user object
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NamePage(user: widget.user)),
                      );
                    } else {
                      setState(() {
                        errorMessage = 'Please fill in all fields.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(350, 45),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

extension PasswordValidator on String {
  bool get isValid {
    // Tambahkan logika validasi password sesuai kebutuhan
    return length >= 8 &&
        contains(RegExp(r'[a-z]')) &&
        contains(RegExp(r'[A-Z]')) &&
        contains(RegExp(r'[0-9]'));
  }
}

class NamePage extends StatefulWidget {
  final UserModel user; // Add this line

  NamePage({required this.user}); // Add this line
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  DBHelper dbHelper = DBHelper();
  TextEditingController nameController = TextEditingController();
  bool isNameEmpty = false;
  bool consentToTerms = false;
  bool subscribeToEmails = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
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
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "What's your full name?",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  Text(
                    "This is used to build your profile and collection on Artsy.",
                    style: TextStyle(fontSize: 13.5),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {
                      isNameEmpty = value.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "First and last name",
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText: isNameEmpty ? "Name field is required" : null,
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 151, 141, 141)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: isNameEmpty
                        ? null
                        : IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                nameController.clear();
                              });
                            },
                          ),
                  ),
                ),
              ),
              SizedBox(height: 13),
              CheckboxListTile(
                activeColor: Colors.black,
                checkColor: Colors.white,
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "By checking this box, you consent to out ",
                        style: TextStyle(
                            // fontSize: 13,
                            ),
                      ),
                      TextSpan(
                        text: 'Terms of use, Privacy Policy',
                        style: TextStyle(
                          // fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Conditions of Sale',
                        style: TextStyle(
                          // fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: consentToTerms,
                onChanged: (value) {
                  setState(() {
                    consentToTerms = value!;
                  });
                },
              ),
              SizedBox(height: 13),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.black,
                title: Text(
                  "Dive deeper into the art market with Artsy emails. Subscribe to hear about our products, services, editorials, and other promotional content. Unsubscribe at any time.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: subscribeToEmails,
                onChanged: (value) {
                  setState(() {
                    subscribeToEmails = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (!isNameEmpty && consentToTerms) {
                      widget.user.name = nameController.text;
                      if (widget.user.email == 'admin@artsy.com' &&
                          widget.user.password == 'Admin123') {
                        dbHelper.insertUser(widget.user);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminDashboardPage()),
                        );
                      } else {
                        // If not admin credentials, navigate to the regular home page
                        dbHelper.insertUser(widget.user);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    } else {
                      setState(() {
                        errorMessage = 'Please fill in all fields.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(350, 45),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
