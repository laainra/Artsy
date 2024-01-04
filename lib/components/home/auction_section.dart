import 'package:flutter/material.dart';

class AuctionSection extends StatefulWidget {
  @override
  AuctionSectionState createState() => AuctionSectionState();
}

class AuctionSectionState extends State<AuctionSection> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Auctions",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              ">", // Change from "<" to ">"
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
            )
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return AuctionCard();
            },
          ),
        ),
      ],
    );
  }
}
class AuctionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/art3.png", // Replace with actual image URL
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/art4.png", // Replace with actual image URL
                      height: 70,
                      width: 70,

                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      "assets/images/art5.png", // Replace with actual image URL
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Collection Name",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Collection",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
