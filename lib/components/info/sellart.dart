import 'package:flutter/material.dart';

class SellArtSection extends StatefulWidget {
  const SellArtSection({Key? key}) : super(key: key);

  @override
  _SellArtSectionState createState() => _SellArtSectionState();
}

class _SellArtSectionState extends State<SellArtSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              // This will make the container take up the full width of the screen
              width: double.infinity,
              child: Image.asset(
                "assets/images/art1.png",
                width: 600,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/art2.png',
                      height: 160,
                      width: 90,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/art3.png',
                      height: 180,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sell art from your colection",
                  style: TextStyle(fontSize: 25),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "With our global reach and art market expertise, our specialists will find the best sales option for your worrk.",
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // // Navigate to the payment page or handle purchase logic
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PurchasePage(
                    //       // Pass relevant details to the payment page if needed
                    //       artworkDetails: widget.artworkDetails,
                    //     ),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(330, 50),
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Start Selling",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    // // Navigate to the payment page or handle purchase logic
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PurchasePage(
                    //       // Pass relevant details to the payment page if needed
                    //       artworkDetails: widget.artworkDetails,
                    //     ),
                    //   ),
                    // );
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(330, 50),
                    side: BorderSide(color: Colors.black),
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Get in Touch",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
