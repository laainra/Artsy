import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors
            .white, // Sesuaikan dengan warna latar belakang yang diinginkan
        leading: TextButton(
          child: Text("<",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w100,
              )),
          onPressed: () {
            // Fungsi untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 100.0, bottom: 50),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_form');
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fixedSize:
                        Size(400, 50), // Atur lebar dan tinggi sesuai kebutuhan
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 18,
                      ),
                      Text('Continue with Email',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                OutlinedButton(
                  onPressed: () {
                    // Fungsi untuk menangani tombol Google
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(color: Colors.black),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fixedSize:
                        Size(400, 50), // Atur lebar dan tinggi sesuai kebutuhan
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        height: 18.0,
                        width: 18.0,
                      ),
                      Text('Continue with Google',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                OutlinedButton(
                  onPressed: () {
                    // Fungsi untuk menangani tombol Facebook
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fixedSize:
                        Size(400, 50), // Atur lebar dan tinggi sesuai kebutuhan
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/facebook_logo.png',
                        height: 18.0,
                        width: 18.0,
                      ),
                      Text('Continue with Facebook',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "By tapping Continue with Facebook, Google you agree to Artsy's ",
                    ),
                    TextSpan(
                      text: 'Terms of use',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80.0),
            Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Center(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/register');
            //   },
            //   child: Text(
            //     'Sign up',
            //     style: TextStyle(
            //         decoration: TextDecoration.underline, fontSize: 16.0),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
