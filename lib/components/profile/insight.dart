import 'package:flutter/material.dart';

class InsightTab extends StatefulWidget {
  const InsightTab({Key? key}) : super(key: key);
  @override
  _InsightTabState createState() => _InsightTabState();
}

class _InsightTabState extends State<InsightTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Gain Deeper Knowledge od your Collection",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Get free market insight about the artist you collect. ",
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
              "assets/images/insight.jpg",
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
                "Upload Artwork",
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
