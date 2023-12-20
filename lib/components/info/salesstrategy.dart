import 'package:flutter/material.dart';

class SalesStrategySection extends StatefulWidget {
  const SalesStrategySection({Key? key}) : super(key: key);

  @override
  _SalesStrategySectionState createState() => _SalesStrategySectionState();
}

class _SalesStrategySectionState extends State<SalesStrategySection> {
  Widget buildStrategyCard(String image, String title, String description) {
    return Container(
      width: 330,
      padding: EdgeInsets.all(8),
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
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.white),
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      // width: 350,
      height: 620,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "A sales strategy tailored to your artwork",
            style: TextStyle(fontSize: 26, color: Colors.white),
            overflow: TextOverflow.clip,
          ),
          Text(
            "A dedicated specialist works with you to select the best sales option for your artwork",
            style: TextStyle(fontSize: 13, color: Colors.white),
            overflow: TextOverflow.clip,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildStrategyCard('assets/images/art1.png', 'Auctions',
                    "Our curated auctions provide you with multiple opportunities to reach the widest audience and successfully achieve your artwork's full potential."),
                buildStrategyCard('assets/images/art2.png', 'Private Sales',
                    "We offer tailored and discreet sales arrangements for our collectors' highest value and most sensitive artworks."),
                buildStrategyCard('assets/images/art3.png', 'Online storefront',
                    "When your work is listed directly on Artsy.net—the world's largest online art marketplace—it reaches over 3 million art lovers."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
