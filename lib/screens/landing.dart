import 'package:flutter/material.dart';
// import 'package:artsy_prj/screens/login.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/landing.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // AppBar with Logo
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(
                'assets/images/logo.png', // Replace with your logo asset path
                height: 30, // Adjust the height as needed
              ),
            ),

            // Content in the Bottom of the Screen
            Positioned(
              bottom: 10,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text with Font Size 70
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Collect Art by the World's Leading Artist ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Build your personalized profile, get market insight, buy and sell art with confidence",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Sign Up Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            minimumSize: Size(160, 45),
                            // Add a margin of 20 to all edges
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),

                        // Login Button
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            minimumSize: Size(160, 45),
                            // Add a margin of 20 to all edges
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

// Text below Buttons
                  Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Wrap(
                      children: [
                        Text(
                          'Our Soldiers Led Under Prince Diponegoro, 1979',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
