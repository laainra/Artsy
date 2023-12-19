import 'package:flutter/material.dart';

class SalesStrategySection extends StatefulWidget {
  const SalesStrategySection({Key? key}) : super(key: key);
  @override
  _SalesStrategySectionState createState() => _SalesStrategySectionState();
}

class _SalesStrategySectionState extends State<SalesStrategySection> {
  Widget buildStrategyCard(String image, String title, String description) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 300,
            width: 300,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "A slaes strategy tailored to your artwork",
            style: TextStyle(fontSize: 24),
            overflow: TextOverflow.clip,
          ),
          Text(
            "A dedicated specialist works with you to select the best sales option for your artwork",
            style: TextStyle(fontSize: 15),
            overflow: TextOverflow.clip,
          ),
          ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildStrategyCard('assets/images/art1.png', 'Auctions',
                  "Our curated auctions provide you with multiole opportunities to reach the widest audience and successfully achieve your artwork's full potential."),
              buildStrategyCard('assets/images/art2.png', 'Private Sles',
                  "We offer tailored and discreet sales arrangements for our collectors highest value and most sensitive artworks."),
              buildStrategyCard('assets/images/art3.png', 'Online storefront',
                  "When your work is listed directly on Artsy.net-the world's largest online art marketplace-it reaches over 3 millions art lovers."),
            ],
          )
        ],
      ),
    );
  }
}
