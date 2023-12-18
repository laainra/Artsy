import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:artsy_prj/screens/home.dart';
import 'package:artsy_prj/screens/admin/admindashboard.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailEmpty = false;
  bool isEmailValid = true;
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
              "Log In",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EMAIL",
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 8),
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
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PASSWORD",
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      isPasswordEmpty = value.isEmpty;
                      isPasswordValid = value.isValid;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText:
                        isPasswordEmpty ? "Password field is required" : null,
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 151, 141, 141)),
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
              ],
            ),
            SizedBox(height: 2),
            GestureDetector(
              onTap: () {
                // Fungsi untuk menangani tombol Forgot Password
                // (Beri aksi sesuai kebutuhan)
              },
              child: Center(
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 86, 84, 84),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),
            if (errorMessage.isNotEmpty)
              Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                bool isEmailEmpty = emailController.text.isEmpty;
                bool isPasswordEmpty = passwordController.text.isEmpty;
                if (!isEmailEmpty &&
                    isEmailValid &&
                    !isPasswordEmpty &&
                    isPasswordValid) {
                  // Check if email and password match admin credentials
                  if (emailController.text == 'admin@artsy.com' &&
                      passwordController.text == 'Admin123') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminDashboardPage()),
                    );
                  } else {
                    // If not admin credentials, show error message
                    Navigator.pushNamed(context, '/home');
                  }
                } else {
                  // Show error message for empty fields
                  setState(() {
                    errorMessage = 'Please provide correct password and email!';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isEmailEmpty || isPasswordEmpty
                    ? Colors.grey
                    : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize: Size(350, 45),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
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
