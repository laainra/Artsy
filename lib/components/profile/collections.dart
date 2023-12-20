import 'package:flutter/material.dart';

class CollectionsTab extends StatefulWidget {
  const CollectionsTab({Key? key}) : super(key: key);
  @override
  _CollectionsTabState createState() => _CollectionsTabState();
}

class _CollectionsTabState extends State<CollectionsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Know Your Collection Better",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Manage your colection online and get free market insight",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              overflow: TextOverflow.clip,
            ),
            SizedBox(
              height: 15,
            ),
            Image.asset(
              "assets/images/profile.jpg",
              width: 350,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15,
            ),
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
                "Add to My Collection",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            TextButton(
                onPressed: () {
                  //
                },
                child: Text("Learn More"))
          ],
        ));
  }
}
