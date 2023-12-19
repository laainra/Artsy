import 'package:flutter/material.dart';

class HowSection extends StatefulWidget {
  const HowSection({Key? key}) : super(key: key);

  @override
  _HowSectionState createState() => _HowSectionState();
}

class _HowSectionState extends State<HowSection> {
  Widget buildTextField(String no, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            no,
            style: TextStyle(fontSize: 24),
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
          Text(
            "How it works",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          buildTextField('01', 'Submit your artwork',
              "Enter the artist' nama on the submission page. If the artist in our database, you'll be able to upload images and artwork details"),
          SizedBox(
            height: 10,
          ),
          buildTextField('02', 'Meet your expert',
              "One of our specialists will review your submission and determine the best sales option."),
          SizedBox(
            height: 10,
          ),
          buildTextField('03', 'Get a sales option',
              "Review your tailored sales strategy and price estimate. We'll select the be3st way to sell your work--either at auction, through private sale, or a direct listing on Artsy "),
          SizedBox(
            height: 10,
          ),
          buildTextField('04', 'Sell your work',
              "Keep your work until it sells, then let our team handle the logistics. No costly presale insurance, shipping, or handling fees "),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
