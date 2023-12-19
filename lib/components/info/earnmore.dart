import 'package:flutter/material.dart';

class EarnMoreSection extends StatefulWidget {
  const EarnMoreSection({Key? key}) : super(key: key);

  @override
  _EarnMoreSectionState createState() => _EarnMoreSectionState();
}

class _EarnMoreSectionState extends State<EarnMoreSection> {
  Widget buildTextField(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180.0),
              border: Border.all(
                color: Colors.black, // Set the border color
                width: 2.0, // Set the border width
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Icon(
              icon,
              size: 30.0,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.clip,
          ),
          Text(
            subtitle,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          buildTextField(
              Icons.attach_money_outlined,
              'Earn more from your sale',
              'With lower fees than traditional auction houses and dealers, you take home more of the final sale price'),
          SizedBox(
            height: 10,
          ),
          buildTextField(Icons.star_border_outlined, 'Tap into our expertise',
              'Our team has a wealth of experience in the secondary art market. A dedicates specialist will be with you every step of the way'),
          SizedBox(
            height: 10,
          ),
          buildTextField(Icons.web_outlined, 'Reach a global network',
              "With the world's largest network of collectors, we match your work the most interested buyers in over 190 countries"),
        ],
      ),
    );
  }
}
