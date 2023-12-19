import 'package:flutter/material.dart';

class InterestedSection extends StatefulWidget {
  const InterestedSection({Key? key}) : super(key: key);
  @override
  _InterestedSectionState createState() => _InterestedSectionState();
}

class _InterestedSectionState extends State<InterestedSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.black,
      child: Column(children: [
        Text(
          "Interested in selling multiple artworks? Speak with our team.",
          style: TextStyle(fontSize: 24),
          overflow: TextOverflow.clip,
        ),
      ]),
    );
  }
}
